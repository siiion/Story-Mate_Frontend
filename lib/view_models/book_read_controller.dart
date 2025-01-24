import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:storymate/services/text_pagination_service.dart';
import 'package:storymate/views/book_more_page.dart';

class BookReadController extends GetxController {
  RxList<String> pages = <String>[].obs; // 페이지 목록
  RxInt currentPage = 0.obs; // 현재 페이지
  RxSet<int> bookmarks = <int>{}.obs; // 북마크 저장
  RxBool isUIVisible = true.obs; // 상단바/하단바 가시성
  RxDouble progress = 0.0.obs; // 진행률

  // 뒤로 가기
  void goBack() {
    Get.back();
  }

  // 책 파일 로드
  Future<void> loadBook(String filePath, double screenWidth,
      double screenHeight, TextStyle textStyle) async {
    try {
      final String rawContent = await rootBundle.loadString(filePath);
      final String processedContent = preprocessText(rawContent); // 전처리 추가
      // print(processedContent); // 전처리된 텍스트 출력 (테스트용)
      pages.value =
          paginateText(processedContent, screenWidth, screenHeight, textStyle);
      updateProgress();
    } catch (e) {
      Get.snackbar('Error', '파일을 읽는 데 실패했습니다: $e');
    }
  }

  String preprocessText(String text) {
    text = text.replaceAll('\n', ' ');
    text = text.replaceAll(RegExp(r'\s{3,}'), '\n\n');
    return text.trim();
  }

  // 페이지 진행률 업데이트
  void updateProgress() {
    if (pages.isNotEmpty) {
      progress.value = (currentPage.value + 1) / pages.length;
    }
  }

  // UI 가시성 토글
  void toggleUIVisibility() {
    isUIVisible.value = !isUIVisible.value;
  }

  // 북마크 추가/삭제
  void toggleBookmark() {
    if (bookmarks.contains(currentPage.value)) {
      bookmarks.remove(currentPage.value); // 북마크 삭제
      Get.snackbar('알림', '북마크가 해제되었습니다.');
    } else {
      bookmarks.add(currentPage.value); // 북마크 추가
      Get.snackbar('알림', '북마크가 설정되었습니다.');
    }
  }

  // 이전 페이지로 이동
  void goToPreviousPage() {
    if (currentPage.value > 0) {
      currentPage.value--;
      updateProgress();
    } else {
      Get.snackbar('알림', '첫 페이지입니다.');
    }
  }

  // 다음 페이지로 이동
  void goToNextPage() {
    if (currentPage.value < pages.length - 1) {
      currentPage.value++;
      updateProgress();
    } else {
      Get.snackbar('알림', '마지막 페이지입니다.');
    }
  }

  // 첫 페이지로 리셋
  void resetToFirstPage() {
    currentPage.value = 0;
    updateProgress();
  }

  // 더보기 버튼 클릭 시
  void toMorePage(String title) {
    Get.to(
      BookMorePage(),
      arguments: {
        'title': title,
      },
    );
  }
}
