import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storymate/components/book_app_bar.dart';
import 'package:storymate/components/theme.dart';
import 'package:storymate/view_models/book_more_controller.dart';

class BookMorePage extends StatelessWidget {
  const BookMorePage({super.key});

  @override
  Widget build(BuildContext context) {
    final BookMoreController controller = Get.put(BookMoreController());

    // Get.arguments로 전달받은 데이터를 title로 사용
    final arguments = Get.arguments as Map<String, dynamic>;
    final String title = arguments['title'] ?? '작품 제목';

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: AppTheme.backgroundColor,
        appBar: BookAppBar(
          title: title,
          onLeadingTap: () => controller.goBack(),
        ),
        body: Column(
          children: [
            // 탭바
            TabBar(
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
                  Obx(
                    () => ListView.builder(
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      itemCount: controller.highlights.length,
                      itemBuilder: (context, index) {
                        final highlight = controller.highlights[index];
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // 쪽수와 내용
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 5),
                                    decoration: ShapeDecoration(
                                      color: AppTheme.primaryColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                    ),
                                    child: Text(
                                      highlight["page"]!,
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
                                  // 하이라이트 내용
                                  Text(
                                    highlight["content"]!,
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
                                  // 하이라이트 삭제
                                  controller.removeHighlight(index);
                                },
                                child: Icon(
                                  Icons.delete,
                                  color: AppTheme.primaryColor,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Center(child: Text('Content for Tab 2')),
                  Center(child: Text('Content for Tab 3')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
