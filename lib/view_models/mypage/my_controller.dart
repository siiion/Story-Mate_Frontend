import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:storymate/views/read/book_intro_page.dart';

class MyController extends GetxController {
  final box = GetStorage(); // GetStorage 인스턴스 생성

  // 사용자 정보 상태
  var userName = '사용자'.obs;
  var userBirth = '0000.00.00'.obs;

  @override
  void onInit() {
    super.onInit();
    loadUserInfo();
  }

  /// 저장된 사용자 정보를 불러오기
  void loadUserInfo() {
    userName.value = box.read("userName") ?? "사용자";
    userBirth.value = box.read("userBirth") ?? "0000.00.00";
  }

  /// 작품 소개 화면으로 이동
  void toIntroPage(String title) {
    Get.to(BookIntroPage(), arguments: {
      'title': title,
    });
  }
}
