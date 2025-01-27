import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:storymate/views/book_intro_page.dart';

class BookSearchController extends GetxController {
  // 뒤로 가기
  void goBack() {
    Get.back();
  }

  // 검색어 입력 controller
  final TextEditingController searchController = TextEditingController();

  var selectedCategory = '전체'.obs; // 선택된 카테고리
  var categories = ['전체', '서명/저자', '키워드']; // 검색 카테고리
  var keywords = ['동화', '모험', '판타지', '로맨스', '역사', '철학'].obs; // 키워드 예시
  void changeCategory(String category) {
    selectedCategory.value = category;
  }

  // 검색 결과를 관리하는 상태 변수
  RxList<Map<String, String>> searchResults = <Map<String, String>>[].obs;

  // 추천 작품 (샘플 데이터)
  final List<Map<String, String>> allBooks = [
    {"title": "작품 제목 1", "tags": "#태그1 #태그2"},
    {"title": "작품 제목 2", "tags": "#태그3 #태그4"},
    {"title": "작품 제목 3", "tags": "#태그5 #태그6"},
    {"title": "작품 제목 4", "tags": "#태그7 #태그8"},
  ];

  // 검색 기능
  void searchBooks(String query) {
    if (query.isEmpty) {
      // 검색어가 비어있으면 결과 초기화
      searchResults.clear();
    } else {
      // 검색어에 따라 결과 필터링
      searchResults.value = allBooks
          .where((book) =>
              book["title"]!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
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
}
