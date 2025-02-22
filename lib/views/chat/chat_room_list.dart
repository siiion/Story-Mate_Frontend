import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../components/custom_bottom_bar.dart';
import '../../../routes/app_routes.dart';

class ChatRoomListScreen extends StatefulWidget {
  const ChatRoomListScreen({super.key});

  @override
  _ChatRoomListScreenState createState() => _ChatRoomListScreenState();
}

class _ChatRoomListScreenState extends State<ChatRoomListScreen> {
  List<dynamic> chatRooms = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchChatRooms();
  }

  // 🔹 로그인한 사용자의 채팅방 목록 가져오기 (GET /api/chat-rooms)
  Future<void> fetchChatRooms() async {
    setState(() {
      isLoading = true;
    });

    final token = await getToken();
    if (token == null) {
      print("토큰이 없습니다. 로그인 후 다시 시도해주세요.");
      return;
    }

    try {
      final response = await http.get(
        Uri.parse(
            'https://be.dev.storymate.site/api/chat-rooms?page=0&size=10'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      String decodedResponse = utf8.decode(response.bodyBytes);
      final responseData = json.decode(decodedResponse);

      if (response.statusCode == 200) {
        setState(() {
          chatRooms = responseData['chatRoomResDtos'] ?? [];
          isLoading = false;
        });
      } else {
        print("채팅방 조회 실패: ${response.statusCode}");
        print("서버 응답: $decodedResponse");
      }
    } catch (e) {
      print("채팅방 조회 중 오류 발생: $e");
    }
  }

  // 🔹 SharedPreferences에서 토큰 가져오기
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('accessToken');
  }

  // 🔹 특정 채팅방으로 이동 (이전 대화 보기 기능)
  void openChatRoom(int roomId, String bookTitle) {
    Get.toNamed(AppRoutes.CHAT_HISTORY, arguments: {
      "roomId": roomId,
      "bookTitle": bookTitle,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          title: Text(
        "이전 대화 보기",
        style: TextStyle(
          fontSize: 24,
          color: Colors.black,
          fontFamily: 'Jua',
          fontWeight: FontWeight.bold,
        ),
      )),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : chatRooms.isEmpty
              ? Center(child: Text("참여한 채팅방이 없습니다."))
              : ListView.builder(
                  itemCount: chatRooms.length,
                  itemBuilder: (context, index) {
                    final chatRoom = chatRooms[index];

                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      child: ListTile(
                        leading: chatRoom['charactersImage'] != null
                            ? CircleAvatar(
                                backgroundImage:
                                    NetworkImage(chatRoom['charactersImage']),
                              )
                            : CircleAvatar(
                                child: Text(chatRoom['charactersName'][0]),
                              ),
                        title: Text(chatRoom['title']),
                        subtitle: Text(chatRoom['bookTitle']),
                        trailing: ElevatedButton(
                          onPressed: () => openChatRoom(
                              chatRoom['roomId'], chatRoom['bookTitle']),
                          child: Text("이전 대화 보기"),
                        ),
                      ),
                    );
                  },
                ),
      bottomNavigationBar: CustomBottomBar(currentIndex: 1),
    );
  }
}
