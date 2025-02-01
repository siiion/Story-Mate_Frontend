import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storymate/components/book_app_bar.dart';
import 'package:storymate/components/theme.dart';
import 'package:storymate/view_models/read/book_more_controller.dart';

class BookMorePage extends StatelessWidget {
  const BookMorePage({super.key});

  @override
  Widget build(BuildContext context) {
    final BookMoreController controller = Get.put(BookMoreController());

    // Get.arguments로 전달받은 데이터를 title로 사용
    final arguments = Get.arguments;
    final String title =
        (arguments is Map<String, dynamic> && arguments.containsKey('title'))
            ? arguments['title']
            : '작품 제목';

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: AppTheme.backgroundColor,
        appBar: BookAppBar(
          title: title,
          onLeadingTap: () => controller.goBack(),
        ),
        floatingActionButton: Obx(() {
          if (controller.currentTabIndex.value == 2) {
            // 메모 탭일 경우 플로팅 버튼 표시
            return GestureDetector(
              onTap: () => controller.toAddMemo(),
              child: Container(
                width: 70,
                height: 70,
                decoration: ShapeDecoration(
                  color: const Color(0xFF9B9ECF),
                  shape: const OvalBorder(),
                  shadows: [
                    const BoxShadow(
                      color: Color(0x3F000000),
                      blurRadius: 4,
                      offset: Offset(0, 4),
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: const Icon(
                  Icons.edit,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            );
          } else {
            // 다른 탭일 경우 플로팅 버튼 숨기기
            return SizedBox.shrink(); // 빈 위젯 반환
          }
        }),
        body: Column(
          children: [
            // 탭바
            TabBar(
              onTap: (index) => controller.setTabIndex(index),
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorWeight: 2.5,
              indicatorColor: AppTheme.primaryColor,
              labelColor: AppTheme.primaryColor,
              unselectedLabelColor: Colors.black,
              labelStyle: TextStyle(
                fontSize: 15,
                fontFamily: 'Nanum',
                fontWeight: FontWeight.w600,
                height: 1.33,
                letterSpacing: -0.23,
              ),
              tabs: [
                Tab(
                  text: '하이라이트',
                ),
                Tab(
                  text: '책갈피',
                ),
                Tab(
                  text: '메모',
                ),
              ],
            ),
            // 탭바 컨텐츠
            Expanded(
              child: TabBarView(
                children: [
                  // 하이라이트 탭
                  TabContents(
                    controller: controller,
                    tab: controller.highlights,
                  ),
                  // 책갈피 탭
                  BookmarkTabContents(controller: controller),
                  // 메모 탭
                  TabContents(
                    controller: controller,
                    tab: controller.memos,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 책갈피 탭 내용
class BookmarkTabContents extends StatelessWidget {
  const BookmarkTabContents({
    super.key,
    required this.controller,
  });

  final BookMoreController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GridView.builder(
        padding: const EdgeInsets.all(20),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          childAspectRatio: 0.8,
        ),
        itemCount: controller.bookmarks.length,
        itemBuilder: (context, index) {
          final bookmark = controller.bookmarks[index];
          return Column(
            children: [
              Stack(
                children: [
                  // 배경 컨테이너
                  Container(
                    height: 170,
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(width: 1, color: Colors.black),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Stack(
                        children: [
                          // 책갈피 내용 미리보기 (어둡게 처리)
                          Positioned.fill(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                              child: Container(
                                color: Colors.black.withOpacity(0.1),
                              ),
                            ),
                          ),
                          // 내용 텍스트
                          Positioned.fill(
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  bookmark["content"]!,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontFamily: 'Nanum',
                                    fontWeight: FontWeight.w400,
                                    height: 1.33,
                                    letterSpacing: -0.23,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  maxLines: 4, // 미리보기 최대 줄 수
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // 삭제 버튼
                  Positioned(
                    right: 10,
                    top: 10,
                    child: GestureDetector(
                      onTap: () {
                        controller.removeBookmark(index);
                      },
                      child: const Icon(
                        Icons.delete,
                        color: Color.fromARGB(255, 245, 90, 79),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              // 페이지 번호
              Text(
                bookmark["page"]!,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontFamily: 'Nanum',
                  fontWeight: FontWeight.w600,
                  height: 1.33,
                  letterSpacing: -0.23,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

// 하이라이트 & 메모 탭 내용
class TabContents extends StatelessWidget {
  final dynamic tab;

  const TabContents({
    super.key,
    required this.controller,
    required this.tab,
  });

  final BookMoreController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        itemCount: tab.length,
        itemBuilder: (context, index) {
          final item = tab[index];
          return Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            padding: EdgeInsets.all(10),
            decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 1,
                    color: AppTheme.primaryColor,
                  ),
                  borderRadius: BorderRadius.circular(10),
                )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // 쪽수와 내용
                    Row(
                      children: [
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                          decoration: ShapeDecoration(
                            color: AppTheme.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: Text(
                            item["page"]!,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontFamily: 'Nanum',
                              fontWeight: FontWeight.w400,
                              height: 1.33,
                              letterSpacing: -0.23,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        // 하이라이트/메모 내용
                        Text(
                          item["content"]!,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontFamily: 'Nanum',
                            fontWeight: FontWeight.w600,
                            height: 1.33,
                            letterSpacing: -0.23,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        // 삭제
                        tab == controller.highlights
                            ? controller.removeHighlight(index)
                            : controller.removeMemo(index);
                      },
                      child: Icon(
                        Icons.delete,
                        color: AppTheme.primaryColor,
                      ),
                    ),
                  ],
                ),
                // (메모일 경우) 작성한 날짜
                tab == controller.highlights
                    ? SizedBox() // highlights 탭에서는 날짜를 표시하지 않음
                    : Text(
                        item.containsKey("date")
                            ? controller.formatDate(item["date"])
                            : '', // "date" 키 존재 여부 확인
                        style: TextStyle(
                          color: Color(0xFF9B9ECF),
                          fontSize: 12,
                          fontFamily: 'Nanum',
                          fontWeight: FontWeight.w400,
                          height: 1.67,
                          letterSpacing: -0.23,
                        ),
                      ),
              ],
            ),
          );
        },
      ),
    );
  }
}
