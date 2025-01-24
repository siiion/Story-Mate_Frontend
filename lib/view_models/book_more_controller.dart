import 'package:get/get.dart';
import 'package:intl/intl.dart';

class BookMoreController extends GetxController {
  // 뒤로 가기
  void goBack() {
    Get.back();
  }

  // 현재 탭 인덱스 관리
  var currentTabIndex = 0.obs;
  void setTabIndex(int index) {
    currentTabIndex.value = index;
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

  // 메모 데이터 (임시)
  var memos = <Map<String, dynamic>>[
    {
      "page": "p.5",
      "content": "메모 내용 1입니다.",
      "date": DateTime(2025, 1, 11),
    },
    {
      "page": "p.20",
      "content": "메모 내용 2입니다.",
      "date": DateTime(2025, 1, 11),
    },
    {
      "page": "p.45",
      "content": "메모 내용 3입니다.",
      "date": DateTime(2025, 1, 11),
    },
    {
      "page": "p.60",
      "content": "메모 내용 4입니다.",
      "date": DateTime(2025, 1, 11),
    },
  ].obs;

  // DateTime -> String 변환 함수
  String formatDate(DateTime date) {
    return DateFormat('yyyy/MM/dd').format(date);
  }

  // 하이라이트 삭제 메서드 (UI만)
  void removeHighlight(int index) {
    highlights.removeAt(index);
  }

  // 책갈피 삭제 메서드 (UI만)
  void removeBookmark(int index) {
    bookmarks.removeAt(index);
  }

  // 메모 삭제 메서드 (UI만)
  void removeMemo(int index) {
    memos.removeAt(index);
  }

  // 메모 작성창으로 이동
  void toAddMemo() {
    Get.toNamed('/memo');
  }

  // 메모 추가 메서드 (임시)
  void addMemo(Map<String, dynamic> memo) {
    memos.add(memo);
  }
}
