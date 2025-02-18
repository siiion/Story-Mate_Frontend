import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:storymate/services/api_service.dart';
import 'package:storymate/services/text_pagination_service.dart';
import 'package:storymate/views/read/book_more_page.dart';

import '../../models/highlight.dart';

class BookReadController extends GetxController {
  final ApiService apiService = ApiService();

  RxList<String> pages = <String>[].obs; // 페이지 목록
  RxInt currentPage = 0.obs; // 현재 페이지
  RxSet<int> bookmarks = <int>{}.obs; // 북마크 저장
  RxBool isUIVisible = true.obs; // 상단바/하단바 가시성
  RxDouble progress = 0.0.obs; // 진행률
  RxMap<int, List<Highlight>> highlightsPerPage = <int, List<Highlight>>{}.obs;

  /// 현재 페이지의 하이라이트 목록 가져오기
  List<Highlight> getHighlightsForCurrentPage() {
    return highlightsPerPage[currentPage.value] ?? [];
  }

  /// 하이라이트 추가
  void addHighlight(int start, int end, String content) {
    try {
      debugPrint("[DEBUG] 하이라이트 추가 시도 - 페이지: ${currentPage.value}");
      debugPrint("[DEBUG] startOffset: $start, endOffset: $end");
      debugPrint("[DEBUG] 선택한 텍스트: \"$content\"");

      if (start >= end) {
        debugPrint("[ERROR] 시작 인덱스가 끝 인덱스보다 크거나 같음. 추가하지 않음.");
        return;
      }

      final highlight = Highlight(
        startOffset: start,
        endOffset: end,
        content: content,
      );

      highlightsPerPage.update(
        currentPage.value,
        (existing) => [...existing, highlight],
        ifAbsent: () => [highlight],
      );

      debugPrint("[DEBUG] 하이라이트 추가 완료: $highlight");
    } catch (e) {
      debugPrint("[ERROR] 하이라이트 추가 중 오류 발생: $e");
    }
  }

  /// 하이라이트 삭제
  void removeHighlight(Highlight highlight) {
    try {
      debugPrint("DEBUG] 하이라이트 삭제 시도 - 페이지: ${currentPage.value}");
      debugPrint("삭제할 하이라이트: $highlight");

      if (highlightsPerPage.containsKey(currentPage.value)) {
        highlightsPerPage[currentPage.value]!.removeWhere((h) =>
            h.startOffset == highlight.startOffset &&
            h.endOffset == highlight.endOffset);
        highlightsPerPage.refresh();
        debugPrint("[DEBUG] 하이라이트 삭제 완료.");
      } else {
        debugPrint("[DEBUG] 해당 페이지에 하이라이트가 없음.");
      }
    } catch (e) {
      debugPrint("[ERROR] 하이라이트 삭제 중 오류 발생: $e");
    }
  }

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
  void goToNextPage(int bookId) async {
    if (currentPage.value < pages.length - 1) {
      currentPage.value++;
      updateProgress();
    } else {
      Get.snackbar('알림', '마지막 페이지입니다.');

      // 마지막 페이지까지 읽으면 API 호출
      try {
        await apiService.markBookAsRead(bookId);
        Get.snackbar('알림', '책을 읽음으로 표시하였습니다.');
      } catch (e) {
        Get.snackbar('오류', '책 읽음 표시 중 오류 발생: $e');
      }
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
