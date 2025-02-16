import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:storymate/components/custom_app_bar.dart';
import 'package:storymate/components/custom_bottom_bar.dart';
import 'package:storymate/components/custom_card.dart';
import 'package:storymate/components/recommend_card_item.dart';
import 'package:storymate/components/theme.dart';
import 'package:storymate/view_models/home_controller.dart';
import 'package:storymate/models/book.dart';

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
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: ListView(
          children: [
            SizedBox(height: 20.h),
            Obx(() => _buildCategorySection(
                '동화', controller.getBooksByCategory('동화'), controller)),
            Obx(() => _buildCategorySection('단/중편 소설',
                controller.getBooksByCategory('단/중편 소설'), controller)),
            Obx(() => _buildCategorySection(
                '장편 소설', controller.getBooksByCategory('장편 소설'), controller)),
            _buildRecommendedSection(),
            SizedBox(
              height: 20.h,
            ),
            _buildPopularByAgeAndGender(),
            SizedBox(height: 15.h),
          ],
        ),
      ),
    );
  }

  Widget _buildCategorySection(
      String title, List<Book> books, HomeController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.black,
                fontSize: 20.sp,
                fontFamily: 'Jua',
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(width: 10.w),
            GestureDetector(
              onTap: () {
                controller.setCategory(title);
              },
              child: Icon(Icons.arrow_forward_ios, size: 15.w),
            ),
          ],
        ),
        SizedBox(height: 180.h, child: _buildBookList(books, controller)),
        SizedBox(height: 20.h),
      ],
    );
  }

  Widget _buildBookList(List<Book> books, HomeController controller) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: books.length,
      itemBuilder: (context, index) {
        final book = books[index];
        return Padding(
          padding: EdgeInsets.only(top: 10.h, bottom: 10.h, right: 10.w),
          child: CustomCard(
            title: book.title,
            tags: book.tags,
            coverImage: book.coverImage,
            onTap: () {
              controller.toIntroPage(book.title);
            },
          ),
        );
      },
    );
  }

  Widget _buildRecommendedSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'ㅇㅇ님을 위한 추천 작품',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18.sp,
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
    );
  }

  Widget _buildPopularByAgeAndGender() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text(
                '20',
                style: TextStyle(
                  color: AppTheme.primaryColor,
                  fontSize: 18.sp,
                  fontFamily: 'Jua',
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                '대 ',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.sp,
                  fontFamily: 'Jua',
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                '여성',
                style: TextStyle(
                  color: AppTheme.primaryColor,
                  fontSize: 18.sp,
                  fontFamily: 'Jua',
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                '에게 인기 많아요',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.sp,
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
    );
  }
}
