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

  //  로그인한 사용자의 채팅방 목록 가져오기 (GET /api/chat-rooms)
  Future<void> fetchChatRooms() async {
    setState(() {
      isLoading = true;
    });

    final token = await getToken();
    if (token == null) {
      print(" 토큰이 없습니다. 로그인 후 다시 시도해주세요.");
      setState(() => isLoading = false);
      return;
    }

    try {
      final response = await http.get(
        Uri.parse(
            'https://be.dev.storymate.site/api/chat-rooms?page=0&size=10'),
        headers: {'Authorization': 'Bearer $token'},
      );

      String decodedResponse = utf8.decode(response.bodyBytes);
      final responseData = json.decode(decodedResponse);

      print(" 서버 응답: $decodedResponse"); //  서버 응답을 출력하여 확인
      if (responseData.containsKey('data') && responseData['data'] != null) {
        final List<dynamic> chatRoomList =
            responseData['data']['chatRoomResDtos'] ?? [];

        if (response.statusCode == 200) {
          setState(() {
            chatRooms = chatRoomList; //  올바르게 chatRooms 업데이트
            isLoading = false;
          });

          if (chatRooms.isEmpty) {
            print(" 채팅방 데이터가 비어 있습니다.");
          } else {
            print(" 불러온 채팅방 개수: ${chatRooms.length}");
          }
        } else {
          print(" 채팅방 조회 실패: ${response.statusCode}");
          print("서버 응답: $decodedResponse");
          setState(() => isLoading = false);
        }
      } else {
        print(" 'data' 키가 서버 응답에 없습니다.");
        setState(() => isLoading = false);
      }
    } catch (e) {
      print(" 채팅방 조회 중 오류 발생: $e");
      setState(() => isLoading = false);
    }
  }

  //  SharedPreferences에서 토큰 가져오기
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('accessToken');
  }

  //  특정 채팅방으로 이동 (이전 대화 보기 기능)
  void openChatRoom(int roomId, String? bookTitle) {
    Get.toNamed(AppRoutes.CHAT_HISTORY, arguments: {
      "roomId": roomId,
      "bookTitle": bookTitle ?? "",
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "이전 대화 보기",
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontFamily: 'Jua',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : (chatRooms.isEmpty || chatRooms == null)
              ? const Center(
                  child: Text(
                    "참여한 채팅방이 없습니다.",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                )
              : Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        "🔥 불러온 채팅방 개수: ${chatRooms.length}",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: chatRooms.length,
                        itemBuilder: (context, index) {
                          final chatRoom = chatRooms[index];
                          final roomId = chatRoom['roomId'] ?? 0;
                          final title = chatRoom['title'] ?? "알 수 없음";
                          final bookTitle = chatRoom['bookTitle'] ?? "알 수 없음";
                          final charactersName =
                              chatRoom['charactersName'] ?? "?";
                          final charactersImage = chatRoom['charactersImage'];

                          return Card(
                            margin: EdgeInsets.symmetric(
                                vertical: 6, horizontal: 12),
                            color: Colors.purple[30],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 16),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  //  캐릭터 이미지 or 첫 글자 CircleAvatar
                                  charactersImage != null &&
                                          charactersImage.isNotEmpty
                                      ? CircleAvatar(
                                          radius: 22,
                                          backgroundImage:
                                              NetworkImage(charactersImage),
                                        )
                                      : CircleAvatar(
                                          radius: 22,
                                          child: Text(
                                            charactersName.substring(0, 1),
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                  SizedBox(width: 12), //  간격 추가

                                  //  채팅방 제목 및 책 제목
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          title,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          overflow:
                                              TextOverflow.ellipsis, // 긴 텍스트 줄임
                                          maxLines: 1,
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          bookTitle,
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey[600]),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                      ],
                                    ),
                                  ),

                                  //  이전 대화 보기 버튼
                                  ElevatedButton(
                                    onPressed: () {
                                      if (roomId != 0) {
                                        openChatRoom(roomId, bookTitle);
                                      } else {
                                        print(" roomId가 0이므로 이동하지 않음");
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 6),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        side: BorderSide(
                                            color: Colors.purple[50]!,
                                            width: 1),
                                      ),
                                    ),
                                    child: Text(
                                      "이전 대화 보기",
                                      style: TextStyle(
                                          color: Colors.purple, fontSize: 12),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
      bottomNavigationBar: const CustomBottomBar(currentIndex: 1),
    );
  }
}
