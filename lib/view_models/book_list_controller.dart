import 'package:get/get.dart';

class BookListController extends GetxController {
  // 기본 데이터
  var items = List<Map<String, String>>.generate(
    10,
    (index) => {
      "title": "작품 제목 ${index + 1}",
      "tags": "#Tag${index + 1} #Example",
    },
  ).obs;

  // 정렬 옵션
  final sortOptions = ['기본순', '인기순', '최신순'];
  var selectedSort = '기본순'.obs;

  // 정렬된 데이터
  var filteredItems = <Map<String, String>>[].obs;

  @override
  void onInit() {
    super.onInit();
    filteredItems.value = items; // 초기 데이터 설정
  }

  // 정렬 순서 변경
  void changeSortOrder(String sortOrder) {
    selectedSort.value = sortOrder;

    if (sortOrder == '기본순') {
      filteredItems.value = items; // 기본순으로 초기화
    } else if (sortOrder == '인기순') {
      filteredItems.value = [...items]
        ..sort((a, b) => a['title']!.compareTo(b['title']!)); // 예: 제목 기준 정렬
    } else if (sortOrder == '최신순') {
      filteredItems.value = [...items]
        ..sort((a, b) => b['title']!.compareTo(a['title']!)); // 역순 정렬
    }
  }

  void goBack() {
    Get.back();
  }

  void toIntroPage(String title) {
    Get.toNamed('/book_intro', arguments: {'title': title});
  }
}
