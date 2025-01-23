import 'package:get/get.dart';
import 'package:storymate/views/book_intro_page.dart';

class BookListController extends GetxController {
  // 이전 화면으로 이동
  void goBack() {
    Get.back();
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
