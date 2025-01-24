import 'package:get/get.dart';

class BookMoreController extends GetxController {
  // 뒤로 가기
  void goBack() {
    Get.back();
  }

  // 하이라이트 데이터 (임시)
  var highlights = <Map<String, String>>[
    {"page": "p.12", "content": "하이라이트 내용 1"},
    {"page": "p.34", "content": "하이라이트 내용 2"},
    {"page": "p.56", "content": "하이라이트 내용 3"},
    {"page": "p.78", "content": "하이라이트 내용 4"},
  ].obs;

  // 책갈피 데이터 (임시)
  var bookmarks = <Map<String, String>>[
    {"page": "p.5", "content": "책갈피 페이지 내용 1입니다."},
    {"page": "p.20", "content": "책갈피 페이지 내용 2입니다."},
    {"page": "p.45", "content": "책갈피 페이지 내용 3입니다."},
    {"page": "p.60", "content": "책갈피 페이지 내용 4입니다."},
  ].obs;

  // 하이라이트 삭제 메서드 (UI만)
  void removeHighlight(int index) {
    highlights.removeAt(index);
  }

  // 책갈피 삭제 메서드 (UI만)
  void removeBookmark(int index) {
    bookmarks.removeAt(index);
  }
}
