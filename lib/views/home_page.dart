import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storymate/components/custom_app_bar.dart';
import 'package:storymate/components/custom_bottom_bar.dart';
import 'package:storymate/components/custom_card.dart';
import 'package:storymate/components/recommend_card_item.dart';
import 'package:storymate/components/theme.dart';
import 'package:storymate/view_models/home_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: CustomAppBar(
        title: 'StoryMate',
        backgroundColor: AppTheme.primaryColor,
      ),
      bottomNavigationBar: CustomBottomBar(
        currentIndex: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          children: [
            SizedBox(
              height: 20,
            ),
            _buildCategorySection('동화', controller.fairyTales, controller),
            _buildCategorySection(
                '단/중편 소설', controller.shortNovels, controller),
            _buildCategorySection('장편 소설', controller.longNovels, controller),
            // 사용자 맞춤 추천 작품 (작품)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'ㅇㅇ님을 위한 추천 작품',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: 'Jua',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Center(
                  child: RecommendCardItem(
                    title: '작품 제목',
                    tag: '#태그 #3개 #들어감',
                    isCharacter: false,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            // 사용자 연령대/성별 기준 인기 작품 (캐릭터)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      // 사용자의 연령대
                      Text(
                        '20',
                        style: TextStyle(
                          color: AppTheme.primaryColor,
                          fontSize: 18,
                          fontFamily: 'Jua',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        '대 ',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontFamily: 'Jua',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      // 사용자의 성별
                      Text(
                        '여성',
                        style: TextStyle(
                          color: AppTheme.primaryColor,
                          fontSize: 18,
                          fontFamily: 'Jua',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        '에게 인기 많아요',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontFamily: 'Jua',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: RecommendCardItem(
                    title: '작품 제목',
                    tag: '#태그 #3개 #들어감',
                    character: '캐릭터명',
                    characterIntro: '한 줄 소개',
                    isCharacter: true,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategorySection(
      String title, RxList books, HomeController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontFamily: 'Jua',
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(width: 10),
            GestureDetector(
              onTap: () {
                controller.setCategory(title);
              },
              child: Icon(Icons.arrow_forward_ios, size: 15),
            ),
          ],
        ),
        SizedBox(
            height: 180, child: Obx(() => _buildBookList(books, controller))),
        SizedBox(height: 20),
      ],
    );
  }

  Widget _buildBookList(RxList books, HomeController controller) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: books.length,
      itemBuilder: (context, index) {
        final book = books[index];
        return Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10, right: 10),
          child: CustomCard(
            title: book.title,
            tags: book.tags,
            coverImage: book.coverImage, // 이미지 경로 전달
            onTap: () {
              controller.toIntroPage(book.title);
            },
          ),
        );
      },
    );
  }
}
