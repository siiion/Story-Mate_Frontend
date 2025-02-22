import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/web_socket_channel.dart'; // 추가된 부분
import '../../../components/custom_bottom_bar.dart';
import '../../../routes/app_routes.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CharacterSelectionScreen extends StatefulWidget {
  const CharacterSelectionScreen({super.key});

  @override
  State<CharacterSelectionScreen> createState() =>
      _CharacterSelectionScreenState();
}

class _CharacterSelectionScreenState extends State<CharacterSelectionScreen> {
  final TextEditingController searchController = TextEditingController();

  // 기존 하드코딩된 캐릭터 데이터 유지
  final List<Map<String, dynamic>> localCharacters = [
    {
      "id": 1,
      "name": "김첨지",
      "book": "운수좋은날",
      "image": "assets/kim_cheomji.png"
    },
    {"id": 2, "name": "인어공주", "book": "인어공주", "image": "assets/mermaid.png"},
    {
      "id": 3,
      "name": "성냥팔이 소녀",
      "book": "성냥팔이소녀",
      "image": "assets/TheLittleGirl.png"
    },
    {"id": 4, "name": "심봉사", "book": "심봉사", "image": "assets/SimCheong.png"},
    {"id": 5, "name": "엄지공주", "book": "엄지공주", "image": "assets/mermaid2.png"},
    {"id": 6, "name": "동백꽃", "book": "동백꽃", "image": "assets/Dongbaekkkot.png"},
    {"id": 7, "name": "시골쥐", "book": "시골쥐서울구경", "image": "assets/mouse.png"},
    {"id": 8, "name": "미운 아기 오리", "book": "미운아기오리", "image": "assets/duck.png"},
    {
      "id": 9,
      "name": "허생원",
      "book": "메밀꽃필무렵",
      "image": "assets/theBuckwheatFlower.png"
    },
    {"id": 10, "name": "화자", "book": "날개", "image": "assets/me.png"},
  ];

  List<Map<String, dynamic>> filteredCharacters = [];

  @override
  void initState() {
    super.initState();
    filteredCharacters = List.from(localCharacters);
  }

  // 검색 기능 추가
  void filterCharacters(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredCharacters = List.from(localCharacters);
      } else {
        filteredCharacters = localCharacters
            .where((character) =>
                (character["name"]?.contains(query) ?? false) ||
                (character["book"]?.contains(query) ?? false))
            .toList();
      }
    });
  }

  //이전 대화 보기
  void ChatHistory() {
    Get.toNamed(AppRoutes.CHAT_HISTORY);
  }

  // 채팅방 생성 (POST /api/chat-rooms)
  Future<void> createChatRoom(
      String title, int characterId, String bookTitle) async {
    print(
        "채팅방 생성 요청: title=$title, characterId=$characterId, bookTitle=$bookTitle");

    // 토큰 가져오기
    final token = await getToken();
    if (token == null) {
      print("토큰이 없습니다. 로그인 후 다시 시도해주세요.");
      return;
    }

    try {
      final response = await http.post(
        Uri.parse('https://be.dev.storymate.site/api/chat-rooms'),
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'title': title,
          'charactersId': characterId,
          'bookTitle': bookTitle,
        }),
      );

      //  UTF-8 강제 변환
      String decodedResponse = utf8.decode(response.bodyBytes);
      final responseData = json.decode(decodedResponse);

      if (response.statusCode == 200) {
        final responseData = json.decode(decodedResponse);
        int roomId = responseData['data']['roomId']; // 서버에서 받은 roomId
        String bookTitle =
            responseData['data']['bookTitle']; // 서버에서 받은 bookTitle

        //  한글 깨짐 방지: UTF-8 변환
        bookTitle = utf8.decode(utf8.encode(bookTitle));

        print("서버 응답: $responseData");
        print("채팅방 생성 성공, roomId: $roomId, bookTitle: $bookTitle");

        //  채팅방 생성 후 화면 이동
        Get.toNamed(AppRoutes.CHAT, arguments: {
          "roomId": roomId,
          "bookTitle": bookTitle,
        });

        //  WebSocket 연결
        connectToWebSocket(roomId);
      } else {
        print("채팅방 생성 실패: ${response.statusCode}");
        print("서버 응답: $decodedResponse");
      }
    } catch (e) {
      print("채팅방 생성 중 오류 발생: $e");
    }
  }

  // WebSocket 연결 함수
  void connectToWebSocket(int roomId) {
    // WebSocket 연결 URL은 roomId를 사용하여 연결
    final channel = WebSocketChannel.connect(
      Uri.parse('wss://be.dev.storymate.site/chat/$roomId'),
    );

    // WebSocket 수신 처리
    channel.stream.listen((message) {
      print('Received message: $message');
      // 추가적인 메시지 처리 로직
    });
  }

  // 토큰을 SharedPreferences에서 불러오기
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('accessToken'); // accessToken 가져오기
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          '작품 속 인물과 이야기를 나눠보세요!',
          style: TextStyle(
            fontFamily: 'Jua',
            color: Colors.black,
            fontSize: 15.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: searchController,
              onChanged: (query) => filterCharacters(query),
              decoration: InputDecoration(
                hintText: "인물/작품으로 검색",
                suffixIcon: Icon(Icons.search, color: Color(0xFF9B9FD0)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),

          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 0.8,
                crossAxisCount: 3,
                crossAxisSpacing: 10.w,
                mainAxisSpacing: 10.h,
              ),
              itemCount: filteredCharacters.length,
              itemBuilder: (context, index) {
                final character = filteredCharacters[index];

                return GestureDetector(
                  onTap: () {
                    print("캐릭터 선택됨: ${character["id"]},ID: ${character["id"]}");
                    createChatRoom(
                        character["name"], character["id"], character["book"]);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.grey, width: 2),
                        ),
                        child: CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.grey.shade200,
                          backgroundImage: character["image"] != null
                              ? AssetImage(character["image"]!)
                              : null,
                          child: character["image"] == null
                              ? Text(
                                  character["name"]![0],
                                  style: TextStyle(
                                    fontSize: 24.sp,
                                    color: Colors.black,
                                    fontFamily: 'Jua',
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              : null,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        character["name"]!,
                        style: TextStyle(
                          fontSize: 10.sp,
                          fontFamily: 'Jua',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        character["book"]!,
                        style: TextStyle(
                          fontSize: 10.sp,
                          fontFamily: 'Jua',
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(height: 4.h),
                    ],
                  ),
                );
              },
            ),
          ), // 🔹 "이전 대화 보기" 버튼 추가
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: ChatHistory,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                backgroundColor: Colors.white, // 버튼 색상
              ),
              child: Text(
                "이전 대화 보기",
                style: TextStyle(
                    fontFamily: 'Jua',
                    color: Colors.black,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomBar(currentIndex: 0),
    );
  }
}
