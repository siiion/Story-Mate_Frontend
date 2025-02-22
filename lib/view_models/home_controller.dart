import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:storymate/models/book.dart';
import 'package:storymate/routes/app_routes.dart';
import 'package:storymate/views/read/book_intro_page.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class HomeController extends GetxController {
  final box = GetStorage();
  String userName = '사용자';
  int userAgeGroup = 20; // 기본 연령대

  // 전체 책 목록
  var books = <Book>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadBooks();
    userName = box.read("userName") ?? "사용자";
    _calculateUserAgeGroup(); // 연령대 계산
  }

  void loadBooks() {
    final List<Map<String, dynamic>> localCharacters = [
      {
        "id": 1,
        "name": "김첨지",
        "book": "운수 좋은 날",
        "image": "assets/kim_cheomji.png"
      },
      {"id": 2, "name": "인어공주", "book": "인어공주", "image": "assets/mermaid.png"},
      {
        "id": 3,
        "name": "성냥팔이 소녀",
        "book": "성냥팔이 소녀",
        "image": "assets/TheLittleGirl.png"
      },
      {"name": "심청이", "book": "심봉사", "image": "assets/SimCheong.png"},
      {"name": "엄지공주", "book": "엄지공주", "image": "assets/mermaid2.png"},
      {"name": "윤이", "book": "동백꽃", "image": "assets/Dongbaekkkot.png"},
      {"name": "시골쥐", "book": "시골 쥐 서울 구경", "image": "assets/mouse.png"},
      {"name": "미운 아기 오리", "book": "미운 아기 오리", "image": "assets/duck.png"},
      {
        "name": "허생원",
        "book": "메밀꽃 필 무렵",
        "image": "assets/theBuckwheatFlower.png"
      },
      {"name": "화자", "book": "날개", "image": "assets/me.png"},
    ];

    books.assignAll([
      Book(
        bookId: 7,
        title: "시골 쥐 서울 구경",
        tags: ["동화", "교훈", "이솝우화"],
        coverImage: "assets/books/fairy_1.png",
        category: "동화",
        author: "방정환",
        publishedYear: "1926",
        description: "시골 쥐와 서울 쥐의 삶을 비교하는 유명한 우화입니다.",
        characterName:
            _getCharacterInfo("시골 쥐 서울 구경", localCharacters)["characterName"] ??
                "",
        characterImage: _getCharacterInfo(
                "시골 쥐 서울 구경", localCharacters)["characterImage"] ??
            "assets/characters/default.png",
        characterDescription: _getCharacterInfo(
                "시골 쥐 서울 구경", localCharacters)["characterDescription"] ??
            "",
      ),
      Book(
        bookId: 8,
        title: "미운 아기 오리",
        tags: ["동화", "교훈", "안데르센"],
        coverImage: "assets/books/fairy_2.png",
        category: "동화",
        author: "안데르센",
        publishedYear: "1843",
        description: "자신의 정체성을 찾는 아기 오리의 성장 이야기입니다.",
        characterName:
            _getCharacterInfo("미운 아기 오리", localCharacters)["characterName"] ??
                "",
        characterImage:
            _getCharacterInfo("미운 아기 오리", localCharacters)["characterImage"] ??
                "assets/characters/default.png",
        characterDescription: _getCharacterInfo(
                "미운 아기 오리", localCharacters)["characterDescription"] ??
            "",
      ),
      Book(
        bookId: 3,
        title: "성냥팔이 소녀",
        tags: ["안데르센", "동화", "슬픔"],
        coverImage: "assets/books/fairy_4.png",
        category: "동화",
        author: "안데르센",
        publishedYear: "1845",
        description: "추운 겨울밤, 성냥을 팔며 희망을 꿈꾸는 소녀의 이야기입니다.",
        characterName:
            _getCharacterInfo("성냥팔이 소녀", localCharacters)["characterName"] ??
                "",
        characterImage:
            _getCharacterInfo("성냥팔이 소녀", localCharacters)["characterImage"] ??
                "assets/characters/default.png",
        characterDescription: _getCharacterInfo(
                "성냥팔이 소녀", localCharacters)["characterDescription"] ??
            "",
        characterId: 3,
      ),
      Book(
        bookId: 5,
        title: "엄지공주",
        tags: ["안데르센", "동화", "모험"],
        coverImage: "assets/books/fairy_5.png",
        category: "동화",
        author: "안데르센",
        publishedYear: "1835",
        description: "엄지손가락 크기로 태어난 소녀가 여러 모험을 겪으며 행복을 찾아가는 이야기입니다.",
        characterName:
            _getCharacterInfo("엄지공주", localCharacters)["characterName"] ?? "",
        characterImage:
            _getCharacterInfo("엄지공주", localCharacters)["characterImage"] ??
                "assets/characters/default.png",
        characterDescription: _getCharacterInfo(
                "엄지공주", localCharacters)["characterDescription"] ??
            "",
      ),
      Book(
        bookId: 2,
        title: "인어공주",
        tags: ["안데르센", "모험", "사랑"],
        coverImage: "assets/books/fairy_6.png",
        category: "동화",
        author: "안데르센",
        publishedYear: "1837",
        description: "바다 속 왕국의 인어공주가 사랑을 위해 자신의 목소리를 희생하는 슬픈 동화입니다.",
        characterName:
            _getCharacterInfo("인어공주", localCharacters)["characterName"] ?? "",
        characterImage:
            _getCharacterInfo("인어공주", localCharacters)["characterImage"] ??
                "assets/characters/default.png",
        characterDescription: _getCharacterInfo(
                "인어공주", localCharacters)["characterDescription"] ??
            "",
        characterId: 2,
      ),
      Book(
        bookId: 1,
        title: "운수 좋은 날",
        tags: ["일제강점기", "아이러니", "전통"],
        coverImage: "assets/books/long_1.png",
        category: "중/장편 소설",
        author: "현진건",
        publishedYear: "1924",
        description: "가난한 인력거꾼이 운이 좋은 날이라고 믿지만, 결국 비극적인 결말을 맞이하는 작품입니다.",
        characterName:
            _getCharacterInfo("운수 좋은 날", localCharacters)["characterName"] ??
                "",
        characterImage:
            _getCharacterInfo("운수 좋은 날", localCharacters)["characterImage"] ??
                "assets/characters/default.png",
        characterDescription: _getCharacterInfo(
                "운수 좋은 날", localCharacters)["characterDescription"] ??
            "",
        characterId: 1,
      ),
      Book(
        bookId: 4,
        title: "심봉사",
        tags: ["고전소설", "동화", "효"],
        coverImage: "assets/books/short_2.png",
        category: "단편 소설",
        description: "맹인 심봉사가 기적적으로 눈을 뜨게 되는 이야기로, 효(孝)에 대한 교훈을 담고 있습니다.",
        characterName:
            _getCharacterInfo("심봉사", localCharacters)["characterName"] ?? "",
        characterImage:
            _getCharacterInfo("심봉사", localCharacters)["characterImage"] ??
                "assets/characters/default.png",
        characterDescription:
            _getCharacterInfo("심봉사", localCharacters)["characterDescription"] ??
                "",
      ),
      Book(
        bookId: 6,
        title: "동백꽃",
        tags: ["봄감자", "사랑", "고전문학"],
        coverImage: "assets/books/short_3.png",
        category: "단편 소설",
        author: "김유정",
        publishedYear: "1936",
        description: "촌스러운 소년과 소녀 사이의 풋풋한 감정을 담은 한국 문학의 대표적인 단편소설입니다.",
        characterName:
            _getCharacterInfo("동백꽃", localCharacters)["characterName"] ?? "",
        characterImage:
            _getCharacterInfo("동백꽃", localCharacters)["characterImage"] ??
                "assets/characters/default.png",
        characterDescription:
            _getCharacterInfo("동백꽃", localCharacters)["characterDescription"] ??
                "",
      ),
      Book(
        bookId: 9,
        title: "메밀꽃 필 무렵",
        tags: ["향토문학", "사랑", "노스탤지어"],
        coverImage: "assets/books/short_4.png",
        category: "단편 소설",
        author: "이효석",
        publishedYear: "1936",
        description: "메밀꽃이 흐드러지게 핀 밤, 장돌뱅이 허생원이 자신의 과거와 사랑을 회상하는 이야기입니다.",
        characterName:
            _getCharacterInfo("메밀꽃 필 무렵", localCharacters)["characterName"] ??
                "",
        characterImage:
            _getCharacterInfo("메밀꽃 필 무렵", localCharacters)["characterImage"] ??
                "assets/characters/default.png",
        characterDescription: _getCharacterInfo(
                "메밀꽃 필 무렵", localCharacters)["characterDescription"] ??
            "",
      ),
      Book(
        bookId: 10,
        title: "날개",
        tags: ["모더니즘", "자아 탐색", "고독"],
        coverImage: "assets/books/long_2.png",
        category: "중/장편 소설",
        author: "이상",
        publishedYear: "1936",
        description:
            "자아의 혼란과 내면의 분열을 상징적으로 그린 작품으로, 주인공의 고독과 존재의 불안이 도심 속에서 심리적으로 표현됩니다.",
        characterName:
            _getCharacterInfo("날개", localCharacters)["characterName"] ?? "",
        characterImage:
            _getCharacterInfo("날개", localCharacters)["characterImage"] ??
                "assets/characters/default.png",
        characterDescription:
            _getCharacterInfo("날개", localCharacters)["characterDescription"] ??
                "",
      ),
    ]);
  }

  // 특정 책 제목과 일치하는 캐릭터 정보를 자동 매핑하는 함수
  Map<String, String> _getCharacterInfo(
      String bookTitle, List<Map<String, dynamic>> characters) {
    final character = characters.firstWhere(
      (char) => char["book"] == bookTitle,
      orElse: () => {"name": "", "image": "assets/characters/default.png"},
    );

    return {
      "characterName": character["name"] ?? "",
      "characterImage": character["image"] ?? "assets/characters/default.png",
      "characterDescription": character["name"] != ""
          ? "${character["name"]}은(는) $bookTitle의 주요 캐릭터입니다."
          : "",
    };
  }

  // 사용자의 생년월일을 통해 연령대 계산
  void _calculateUserAgeGroup() {
    String birthDate = box.read("userBirth") ?? "0000.00.00";
    if (birthDate != "0000.00.00") {
      List<String> parts = birthDate.split('.');
      if (parts.length == 3) {
        int birthYear = int.tryParse(parts[0]) ?? DateTime.now().year;
        int currentYear = DateTime.now().year;
        int age = currentYear - birthYear;

        if (age < 10) {
          userAgeGroup = 10;
        } else if (age < 20) {
          userAgeGroup = 10;
        } else if (age < 30) {
          userAgeGroup = 20;
        } else if (age < 40) {
          userAgeGroup = 30;
        } else {
          userAgeGroup = 40;
        }
      }
    }
  }

  // 특정 연령대에 맞는 추천 작품 선택
  Book getRecommendedBookForAgeAndGender() {
    final random = Random();

    // 연령대별 추천 카테고리 설정
    String category;
    if (userAgeGroup < 20) {
      category = "동화";
    } else if (userAgeGroup < 30) {
      category = "단편 소설";
    } else {
      category = "중/장편 소설";
    }

    // 해당 카테고리의 책 필터링
    List<Book> filteredBooks =
        books.where((book) => book.category == category).toList();

    // 추천할 책이 있는 경우 랜덤 선택, 없으면 기본 값 반환
    return filteredBooks.isNotEmpty
        ? filteredBooks[random.nextInt(filteredBooks.length)]
        : Book(
            bookId: -1,
            title: "추천할 책 없음",
            tags: ["정보 없음"],
            coverImage: "assets/placeholder.png",
            category: "기타",
            author: "알 수 없음",
            publishedYear: "0000",
            description: "현재 추천할 책이 없습니다.",
            characterId: null,
          );
  }

  // 랜덤 추천 작품 가져오기
  Book getRandomBook() {
    if (books.isEmpty) {
      return Book(
        bookId: -1,
        title: "추천할 책 없음",
        tags: ["정보 없음"],
        coverImage: "assets/placeholder.png",
        category: "기타",
        author: "알 수 없음",
        publishedYear: "0000",
        description: "현재 추천할 책이 없습니다.",
      );
    }
    final random = Random();
    return books[random.nextInt(books.length)];
  }

  // 카테고리별 책 목록 반환
  List<Book> getBooksByCategory(String category) {
    return books.where((book) => book.category == category).toList();
  }

  // 카테고리 선택 메서드
  void setCategory(String category) {
    Get.toNamed('/book_list', arguments: category);
  }

  // 작품 소개 화면으로 이동
  void toIntroPage(String title) {
    Get.to(
      BookIntroPage(),
      arguments: {
        'title': title,
      },
    );
  }

  // 토큰을 SharedPreferences에서 불러오기
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('accessToken'); // accessToken 가져오기
  }

  // 채팅방 생성 (POST /api/chat-rooms)
  Future<void> createChatRoom(String title, int characterId) async {
    print("채팅방 생성 요청: title=$title, characterId=$characterId");

    // 토큰 가져오기
    final token = await getToken();
    if (token == null) {
      print("토큰이 없습니다. 로그인 후 다시 시도해주세요.");
      return;
    }

    final response = await http.post(
      Uri.parse('https://be.dev.storymate.site/api/chat-rooms'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode({
        'title': title,
        'charactersId': characterId,
      }),
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      int roomId = responseData['data']['roomId']; // 서버에서 받은 roomId 사용

      print("서버 응답 : $responseData");
      print("채팅방 생성 성공, roomId: $roomId");

      // 채팅방 생성 후 roomId를 기반으로 화면 전환
      Get.toNamed(AppRoutes.CHAT, arguments: {"roomId": roomId});

      // WebSocket 연결 예시 (roomId로 연결)
      connectToWebSocket(roomId);
    } else {
      print("채팅방 생성 실패: ${response.statusCode}");
      print("서버 응답: ${response.body}");
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
}
