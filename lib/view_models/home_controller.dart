import 'package:get/get.dart';
import 'package:storymate/views/book_intro_page.dart';

class HomeController extends GetxController {
  // 선택된 카테고리 정보
  final RxString selectedCategory = ''.obs;

  // 카테고리 선택 메서드
  void setCategory(String category) {
    selectedCategory.value = category;
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
}
