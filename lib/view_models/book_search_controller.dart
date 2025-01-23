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
