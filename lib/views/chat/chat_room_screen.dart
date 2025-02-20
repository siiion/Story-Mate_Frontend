import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ChatRoomScreen extends StatefulWidget {
  const ChatRoomScreen({super.key});

  @override
  _ChatRoomScreenState createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  List<dynamic> messages = [];
  bool isLoading = true;
  late int roomId;
  late String bookTitle;

  @override
  void initState() {
    super.initState();
    final arguments = Get.arguments;
    roomId = arguments["roomId"];
    bookTitle = arguments["bookTitle"];
    fetchChatMessages();
  }

  // 🔹 SharedPreferences에서 토큰 가져오기
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('accessToken');
  }

  // 🔹 채팅 메시지 가져오기 (GET /api/chat-messages/{roomId})
  Future<void> fetchChatMessages() async {
    setState(() {
      isLoading = true;
    });

    final token = await getToken();
    if (token == null) {
      print("토큰이 없습니다. 로그인 후 다시 시도해주세요.");
      setState(() => isLoading = false);
      return;
    }

    try {
      final response = await http.get(
        Uri.parse(
            'https://be.dev.storymate.site/api/chat-messages/$roomId?page=0&size=20'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      String decodedResponse = utf8.decode(response.bodyBytes);
      final responseData = json.decode(decodedResponse);

      if (response.statusCode == 200) {
        setState(() {
          messages = responseData['chatMessages'] ?? [];
          isLoading = false;
        });
      } else {
        print("채팅 메시지 조회 실패: ${response.statusCode}");
        print("서버 응답: $decodedResponse");
        setState(() => isLoading = false);
      }
    } catch (e) {
      print("채팅 메시지 조회 중 오류 발생: $e");
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(bookTitle)),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : messages.isEmpty
              ? Center(child: Text("이전 대화가 없습니다."))
              : ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    final sender = message['sender'] ?? "알 수 없음";
                    final content = message['content'] ?? "";
                    final timestamp = message['timestamp'] ?? "";

                    return ListTile(
                      leading: CircleAvatar(child: Text(sender[0])),
                      title: Text(sender),
                      subtitle: Text(content),
                      trailing: timestamp.contains("T")
                          ? Text(
                              timestamp.split("T")[1].substring(0, 5)) // 시간만 표시
                          : null,
                    );
                  },
                ),
    );
  }
}
