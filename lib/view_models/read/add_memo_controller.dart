import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storymate/components/custom_alert_dialog.dart';
import 'package:storymate/view_models/read/book_more_controller.dart';

class AddMemoController extends GetxController {
  final TextEditingController pageController = TextEditingController();
  final TextEditingController memoController = TextEditingController();
  var characterCount = 0.obs;

  void updateCharacterCount(int count) {
    if (count <= 2000) {
      characterCount.value = count;
    } else {
      // 글자 수 초과 시 작성 중지
      memoController.text = memoController.text.substring(0, 2000);
      memoController.selection = TextSelection.fromPosition(
        TextPosition(offset: 2000),
      );
    }
  }

  void goBackWithPrompt(BuildContext context) async {
    final shouldExit = await showDialog<bool>(
      context: context,
      builder: (context) => CustomAlertDialog(
        question: '메모 작성을 중단하시겠습니까?',
      ),
    );
    if (shouldExit ?? false) {
      Get.back();
    }
  }

  void saveMemo() {
    if (pageController.text.isEmpty || memoController.text.isEmpty) {
      Get.snackbar(
        '오류',
        '페이지와 메모 내용을 모두 입력해주세요.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    final memo = {
      'page': 'p.${pageController.text}', // 페이지 포맷
      'content': memoController.text,
      'date': DateTime.now(),
    };

    // BookMoreController에 메모 추가
    final bookMoreController = Get.find<BookMoreController>();
    bookMoreController.addMemo(memo);

    // 이전 화면으로 돌아가기
    Get.back(result: memo);

    // 알림창 표시
    Get.snackbar(
      '성공',
      '메모가 저장되었습니다.',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
