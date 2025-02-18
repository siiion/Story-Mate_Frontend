import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../view_models/chat_controller.dart';
import 'package:storymate/views/chat/chat_bubble.dart';
import 'package:storymate/models/message.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late WebSocketChannel channel;
  late int roomId;
  late String bookTitle; // 소설 이름
  final ChatController controller = Get.put(ChatController());
  List<dynamic> chatMessages = [];
  int answerCount = 0; // 답변 횟수 추적

  @override
  void initState() {
    super.initState();
    roomId = Get.arguments["roomId"] ?? 0;
    bookTitle = Get.arguments["bookTitle"] ?? ""; // bookTitle 가져오기

    if (roomId != 0) {
      // WebSocket 서버 연결
      channel = WebSocketChannel.connect(
        Uri.parse('wss://be.dev.storymate.site/chat/$roomId'),
      );

      // WebSocket에서 받은 메시지 처리
      channel.stream.listen((message) {
        try {
          // 'sender:roomId:bookTitle:message' 형식으로 구분
          var decodedMessage = message.split(':');
          String sender;
          String messageContent;

          // 메시지가 'sender:roomId:bookTitle:message' 형식일 때
          if (decodedMessage.length >= 4) {
            sender = decodedMessage[0];
            messageContent =
                decodedMessage.sublist(3).join(':'); // 소설 제목 이후 메시지 처리
          } else {
            // 'sender:message' 형식일 때
            sender = decodedMessage[0];
            messageContent = decodedMessage.sublist(1).join(':');
          }

          // 'testUser'의 메시지는 화면에 표시하지 않음
          if (sender == 'testUser') {
            print("testUser 메시지 받음, 화면에 표시하지 않음: $message");
            return;
          }

          // 정상적인 형식의 AI 응답 메시지 화면에 표시
          setState(() {
            chatMessages.add({
              'content': messageContent,
              'sender': sender,
              'isUser': false, // AI 응답
            });
            answerCount++;
          });

          //3번 답변 후 퀴즈 다이얼로그 띄우기
          if (answerCount >= 3) {
            _showQuizDialog(); //퀴즈 다이얼로그 띄움
          }
        } catch (e) {
          print("JSON 파싱 오류: $e");
        }
      });

      // 서버에서 채팅 메시지 가져오기
      fetchChatMessages(roomId);
    }
  }

  // 채팅 메시지 조회 (GET 요청)
  Future<void> fetchChatMessages(int roomId,
      {int page = 0, int size = 10}) async {
    final token = await getToken(); // 저장된 토큰 가져오기

    if (token == null) {
      print("토큰이 없습니다. 로그인 후 다시 시도해주세요.");
      return;
    }

    try {
      final response = await http.get(
        Uri.parse(
            'https://be.dev.storymate.site/api/chat-messages/$roomId?page=$page&size=$size'),
        headers: {
          'Authorization': 'Bearer $token', // Authorization 헤더에 토큰 추가
        },
      );
      print("응답 상태 코드: ${response.statusCode}");
      print("서버 응답 본문: ${response.body}");

      // 만약 응답이 바이트 형식으로 온다면, utf8.decode 사용
      String decodedResponse = utf8.decode(response.bodyBytes);

      if (response.statusCode == 200) {
        final responseData = json.decode(decodedResponse);
        setState(() {
          chatMessages =
              responseData['data']['chatMessages'] ?? []; // null일 경우 빈 배열로 처리
        });
      } else {
        print("채팅 메시지 조회 실패: ${response.statusCode}");
        print("서버 응답: $decodedResponse");
      }
    } catch (e) {
      print("채팅 메시지 조회 중 오류 발생: $e");
    }
  }

  // 저장된 토큰을 SharedPreferences에서 불러오기
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('accessToken'); // accessToken 가져오기
    return token;
  }

  // 메시지 전송 후 UI 갱신 및 채팅 메시지 리스트에 추가
  void sendMessage(String message) {
    if (message.isEmpty) return; // 빈 메시지는 보내지 않음

    // 중복 메시지 전송 방지
    if (chatMessages
        .any((msg) => msg['content'] == message && msg['isUser'] == true)) {
      return; // 동일한 메시지가 이미 전송된 경우 다시 보내지 않음
    }

    String sender = "testUser"; // 사용자가 보낸 메시지
    String bookTitle = Get.arguments["bookTitle"];
    channel.sink.add("$sender:$roomId:$bookTitle:$message");

    // 전송한 메시지를 UI에 바로 반영
    setState(() {
      chatMessages.add({
        'content': message,
        'sender': 'You', // 'testUser' 대신 'You'로 설정
        'isUser': true, // 사용자 메시지
      });
    });

    controller.textController.clear();
    controller.update(); // UI 갱신
  }

  // 퀴즈 다이얼로그를 띄우는 함수
  void _showQuizDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("퀴즈 시작!"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("퀴즈를 풀어보세요!"),
              // 퀴즈 질문을 추가할 수 있습니다.
              // 예시 질문
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(""),
              ),
              TextField(
                decoration: InputDecoration(hintText: "답을 입력하세요"),
                onChanged: (value) {
                  // 입력 받은 답을 처리하는 로직 추가 가능
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text("퀴즈 풀기"),
              onPressed: () {
                // 퀴즈 풀기 버튼 클릭 시 처리
                print("퀴즈 풀기 버튼 클릭");
                Navigator.of(context).pop(); // 다이얼로그 닫기
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    // 화면이 종료될 때 WebSocket 연결 종료
    channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text("대화하기")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: chatMessages.length,
              itemBuilder: (context, index) {
                var message = chatMessages[index];
                return ChatBubble(
                  message: Message(
                      content: message['content'], isUser: message['isUser']),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller.textController,
                    decoration: InputDecoration(hintText: "메시지를 입력하세요"),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    String message = controller.textController.text;
                    sendMessage(message); // 메시지 전송
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
