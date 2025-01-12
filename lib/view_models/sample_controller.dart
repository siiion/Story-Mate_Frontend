// 샘플 컨트롤러

import 'package:get/get.dart';

class SampleController extends GetxController {
  var count = 0.obs; // 상태 정의 (Rx 타입)

  void increment() {
    count++;
  }
}
