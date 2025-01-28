import 'package:get/get.dart';
import 'package:storymate/views/read/book_intro_page.dart';

class MyController extends GetxController {
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
