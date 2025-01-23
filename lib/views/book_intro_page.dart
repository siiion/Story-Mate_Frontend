import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storymate/components/book_app_bar.dart';
import 'package:storymate/components/theme.dart';
import 'package:storymate/view_models/book_intro_controller.dart';

class BookIntroPage extends StatelessWidget {
  const BookIntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    final BookIntroController controller = Get.put(BookIntroController());

    // Get.arguments로 전달받은 데이터를 title로 사용
    final String title = Get.arguments ?? '작품 제목';

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: BookAppBar(
        title: title,
        onLeadingTap: () {
          controller.goBack();
        },
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // 작품 이미지가 들어갈 공간
            Container(
              width: 180,
              height: 210,
              decoration: ShapeDecoration(
                color: Color(0xFFD9D9D9),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(19),
                ),
                shadows: [
                  BoxShadow(
                    color: Color(0x3F000000),
                    blurRadius: 4,
                    offset: Offset(0, 4),
                    spreadRadius: 0,
                  )
                ],
              ),
            ),
            Column(
              children: [
                // 작품명
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontFamily: 'Jua',
                    fontWeight: FontWeight.w400,
                    height: 0.67,
                    letterSpacing: -0.23,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                // 작가명
                Text(
                  '작가명',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontFamily: 'Jua',
                    fontWeight: FontWeight.w400,
                    height: 1,
                    letterSpacing: -0.23,
                  ),
                ),
                // 출판년도
                Text(
                  '(출판년도)',
                  style: TextStyle(
                    color: Color(0xFF7C7C7C),
                    fontSize: 15,
                    fontFamily: 'Jua',
                    fontWeight: FontWeight.w400,
                    height: 1.33,
                    letterSpacing: -0.23,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                // 태그
                Text(
                  '#작품 #태그 #3개',
                  style: TextStyle(
                    color: Color(0xFF9B9ECF),
                    fontSize: 20,
                    fontFamily: 'Jua',
                    fontWeight: FontWeight.w400,
                    height: 1,
                    letterSpacing: -0.23,
                  ),
                ),
              ],
            ),
            // 작품 소개글
            Container(
              width: 310,
              height: 200,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1, color: Color(0xFF9B9ECF)),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 21),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '작품 소개',
                      style: TextStyle(
                        color: Color(0xFF9B9ECF),
                        fontSize: 20,
                        fontFamily: 'Jua',
                        fontWeight: FontWeight.w400,
                        height: 1,
                        letterSpacing: -0.23,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      '작품 소개글이 들어갈 자리입니다.',
                      style: TextStyle(
                        color: Color(0xFF7C7C7C),
                        fontSize: 15,
                        fontFamily: 'Jua',
                        fontWeight: FontWeight.w400,
                        height: 1.33,
                        letterSpacing: -0.23,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // 작품 감상 버튼
            Container(
              width: 270,
              height: 60,
              decoration: ShapeDecoration(
                color: Color(0xFF9B9ECF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Center(
                child: Text(
                  '작품 감상하러 가기',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'Jua',
                    fontWeight: FontWeight.w400,
                    height: 1,
                    letterSpacing: -0.23,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
