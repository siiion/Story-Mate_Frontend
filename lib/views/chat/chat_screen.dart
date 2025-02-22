import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:storymate/views/chat/quiz_screen.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../view_models/chat/chat_controller.dart';
import 'package:storymate/views/chat/chat_bubble.dart';
import 'package:storymate/models/message.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  WebSocketChannel? channel;
  late int roomId;
  late String bookTitle;
  late String charactersName;
  final ChatController controller = Get.put(ChatController());
  List<dynamic> chatMessages = [];
  int answerCount = 0;

  @override
  void initState() {
    super.initState();
    roomId = Get.arguments["roomId"] ?? 0;
    bookTitle = Get.arguments["bookTitle"] ?? "";
    charactersName = Get.arguments["charactersName"] ?? "";

    debugPrint("bookTitle: $bookTitle, charactersName: $charactersName");

    if (roomId != 0) {
      // WebSocket 서버 연결
      channel = WebSocketChannel.connect(
        Uri.parse('wss://be.dev.storymate.site/chat/$roomId'),
      );

      // WebSocket 메시지 수신 및 처리
      channel!.stream.listen((message) {
        try {
          var decodedMessage = message.split(':');
          if (decodedMessage.length < 2) return;

          String sender = decodedMessage[0];
          String messageContent = decodedMessage.sublist(1).join(':');

          if (sender == 'testUser') {
            print("testUser 메시지 받음, 화면에 표시하지 않음: $message");
            return;
          }

          setState(() {
            chatMessages.add({
              'content': messageContent,
              'sender': sender,
              'isUser': false,
            });
            answerCount++;
          });

          if (answerCount >= 3) {
            _showQuizDialog();
          }
        } catch (e) {
          print("WebSocket 메시지 처리 오류: $e");
        }
      });

      fetchChatMessages(roomId);
    }
  }

  Future<void> fetchChatMessages(int roomId,
      {int page = 0, int size = 10}) async {
    final token = await getToken();
    if (token == null) {
      print("토큰이 없습니다. 로그인 후 다시 시도해주세요.");
      return;
    }

    try {
      final response = await http.get(
        Uri.parse(
            'https://be.dev.storymate.site/api/chat-messages/$roomId?page=$page&size=$size'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(utf8.decode(response.bodyBytes));
        setState(() {
          chatMessages = responseData['data']['chatMessages'] ?? [];
        });
      } else {
        print("채팅 메시지 조회 실패: ${response.statusCode}");
      }
    } catch (e) {
      print("채팅 메시지 조회 오류: $e");
    }
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('accessToken');
  }

  void sendMessage(String message) {
    if (message.isEmpty) return;
    if (chatMessages
        .any((msg) => msg['content'] == message && msg['isUser'] == true)) {
      return;
    }

    String sender = "testUser";
    channel?.sink.add("$sender:$roomId:$bookTitle:$message");

    setState(() {
      chatMessages.add({
        'content': message,
        'sender': 'You',
        'isUser': true,
      });
    });

    controller.textController.clear();
    controller.update();
  }

// 퀴즈 다이얼로그 띄우는 함수
  void _showQuizDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "퀴즈 시작!",
            style: TextStyle(
              fontSize: 24.sp,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "퀴즈를 풀어보세요!",
                style: TextStyle(
                  fontSize: 24.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text("퀴즈 풀기"),
              onPressed: () {
                Navigator.of(context).pop();
                Get.to(() => QuizScreen(), arguments: {
                  "characterName": charactersName,
                  "bookTitle": bookTitle,
                });
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    channel?.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "대화하기",
          style: TextStyle(
            fontSize: 20.sp,
            color: Colors.black,
            fontFamily: 'Jua',
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10), // 오른쪽 여백 추가
            child: SizedBox(
              height: 40, // 버튼 높이 조정
              child: ElevatedButton(
                onPressed: () {
                  Get.to(() => QuizScreen(), arguments: {
                    "characterName": charactersName,
                    "bookTitle": bookTitle,
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple[100], // 배경색 (연보라)
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15), // 둥근 모서리
                  ),
                  padding: EdgeInsets.symmetric(
                      horizontal: 15, vertical: 8), // 버튼 내부 패딩
                  minimumSize: Size(100, 36), // 버튼 크기 제한
                ),
                child: Text(
                  "퀴즈 도전하기",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: chatMessages.length,
              itemBuilder: (context, index) {
                var message = chatMessages[index];
                return ChatBubble(
                  message: Message(
                    content: message['content'],
                    isUser: message['isUser'],
                  ),
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
                    sendMessage(message);
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
