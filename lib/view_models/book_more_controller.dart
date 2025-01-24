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

  // 하이라이트 삭제 메서드 (UI만)
  void removeHighlight(int index) {
    highlights.removeAt(index);
  }
}
