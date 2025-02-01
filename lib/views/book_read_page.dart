import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storymate/components/custom_alert_dialog.dart';
import 'package:storymate/components/book_app_bar.dart';
import 'package:storymate/components/theme.dart';
import 'package:storymate/view_models/book_read_controller.dart';

class BookReadPage extends StatelessWidget {
  const BookReadPage({super.key});

  @override
  Widget build(BuildContext context) {
    final BookReadController controller = Get.put(BookReadController());
    // Get.arguments로 전달받은 데이터를 title로 사용
    final arguments = Get.arguments as Map<String, dynamic>;
    final String title = arguments['title'] ?? '작품 제목';
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height * 0.65;
    final textStyle = TextStyle(fontSize: 18, height: 2.5, fontFamily: 'Nanum');

    // 로컬 파일로 테스트 (임시)
    controller.loadBook(
        'assets/book_example.txt', screenWidth, screenHeight, textStyle);

    return Obx(() {
      return Scaffold(
        backgroundColor: AppTheme.backgroundColor,
        appBar: controller.isUIVisible.value
            ? BookAppBar(
                title: title,
                onLeadingTap: () => controller.goBack(),
                isActionVisible: true,
                onBookmarkTap: controller.toggleBookmark, // 북마크 탭 클릭 로직 필요
                bookmarkActive:
                    controller.bookmarks.contains(controller.currentPage.value),
                onMoreTap: () => controller.toMorePage(title), // 더보기 탭 클릭 로직 필요
              )
            : AppBar(
                forceMaterialTransparency: true,
                toolbarHeight: 57,
              ),
        bottomNavigationBar: controller.isUIVisible.value
            ? Container(
                width: MediaQuery.of(context).size.width,
                height: 79,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      width: 0.50,
                      strokeAlign: BorderSide.strokeAlignOutside,
                      color: Color(0xFFA2A2A2),
                    ),
                  ),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 25, bottom: 20, right: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // 리셋 버튼
                      GestureDetector(
                        onTap: () async {
                          bool? result = await showDialog<bool>(
                            context: context,
                            builder: (context) =>
                                CustomAlertDialog(question: '처음부터 다시 읽으시겠습니까?'),
                          );
                          if (result == true) {
                            controller.resetToFirstPage(); // 첫 페이지로 이동
                          }
                        },
                        child: Icon(Icons.undo),
                      ),
                      // 페이지 정보와 프로그레스 바
                      Obx(
                        () => SizedBox(
                          width: 258,
                          child: Slider(
                            value: controller.pages.isEmpty
                                ? 0
                                : controller.currentPage.value.toDouble(),
                            min: 0,
                            max: (controller.pages.isEmpty
                                    ? 1
                                    : controller.pages.length - 1)
                                .toDouble(),
                            divisions: controller.pages.isEmpty
                                ? null
                                : controller.pages.length - 1,
                            activeColor: AppTheme.primaryColor,
                            inactiveColor: Colors.grey.withOpacity(
                                controller.pages.isEmpty ? 0.3 : 1.0),
                            onChanged: controller.pages.isEmpty
                                ? null
                                : (double value) {
                                    controller.currentPage.value =
                                        value.toInt();
                                    controller.updateProgress();
                                  },
                            label: controller.pages.isEmpty
                                ? ''
                                : '${controller.currentPage.value + 1}',
                          ),
                        ),
                      ),
                      Obx(
                        () => Text(
                          '${controller.currentPage.value + 1}/${controller.pages.length}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontFamily: 'Nanum',
                            fontWeight: FontWeight.w400,
                            height: 1.33,
                            letterSpacing: -0.23,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : null,
        body: GestureDetector(
          onTap: controller.toggleUIVisibility,
          onHorizontalDragEnd: (details) {
            if (details.primaryVelocity! < 0) {
              // 오른쪽 -> 왼쪽 스와이프 (다음 페이지)
              controller.goToNextPage();
            } else if (details.primaryVelocity! > 0) {
              // 왼쪽 -> 오른쪽 스와이프 (이전 페이지)
              controller.goToPreviousPage();
            }
          },
          child: Obx(() {
            if (controller.pages.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  controller.pages[controller.currentPage.value],
                  style: textStyle,
                ),
              );
            }
          }),
        ),
      );
    });
  }
}
