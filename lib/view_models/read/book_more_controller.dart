import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:storymate/services/api_service.dart';

class BookMoreController extends GetxController {
  final ApiService apiService = ApiService();

  var memos = <dynamic>[].obs;

  // 뒤로 가기
  void goBack() {
    Get.back();
  }

  // 현재 탭 인덱스 관리
  var currentTabIndex = 0.obs;
  void setTabIndex(int index) {
    currentTabIndex.value = index;
  }

  @override
  void onInit() {
    super.onInit();
    final arguments = Get.arguments as Map<String, dynamic>?;
    final int bookId = arguments?['bookId'] ?? -1;

    if (bookId != -1) {
      fetchMemos(bookId); // 화면 초기화 시 메모 불러오기
    }
  }

  /// 메모 목록 불러오기 (API 연동)
  Future<void> fetchMemos(int bookId) async {
    try {
      List<Map<String, dynamic>> fetchedMemos =
          await apiService.getBookNotes(bookId);

      // API에서 받아온 메모를 업데이트
      memos.assignAll(fetchedMemos);
      print("[DEBUG] 메모 목록 불러오기 완료: $memos");
    } catch (e) {
      print("[ERROR] 메모 불러오기 실패: $e");
    }
  }

  // 메모 삭제 (API 연동)
  Future<void> removeMemo(int bookId, int noteId, int index) async {
    try {
      await apiService.deleteBookNote(bookId, noteId);
      memos.removeAt(index); // UI 업데이트
      print("[DEBUG] 메모 삭제 완료 (ID: $noteId)");
    } catch (e) {
      print("[ERROR] 메모 삭제 실패: $e");
    }
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

  // 메모 작성창으로 이동
  void toAddMemo(int bookId) {
    Get.toNamed('/memo', arguments: {
      'bookId': bookId,
    });
  }

  // 메모 추가 메서드 (임시)
  void addMemo(Map<String, dynamic> memo) {
    memos.add(memo);
  }
}
