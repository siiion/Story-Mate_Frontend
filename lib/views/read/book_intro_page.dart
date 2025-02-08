import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:storymate/components/book_app_bar.dart';
import 'package:storymate/components/theme.dart';
import 'package:storymate/view_models/read/book_intro_controller.dart';

class BookIntroPage extends StatelessWidget {
  const BookIntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    final BookIntroController controller = Get.put(BookIntroController());

    // Get.arguments로 전달받은 데이터를 title로 사용
    final arguments = Get.arguments as Map<String, dynamic>;
    final String title = arguments['title'] ?? '작품 제목';

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
              width: 180.w,
              height: 210.h,
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
                    fontSize: 30.sp,
                    fontFamily: 'Jua',
                    fontWeight: FontWeight.w400,
                    height: 0.67.h,
                    letterSpacing: -0.23.w,
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                // 작가명
                Text(
                  '작가명',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.sp,
                    fontFamily: 'Jua',
                    fontWeight: FontWeight.w400,
                    height: 1.h,
                    letterSpacing: -0.23.w,
                  ),
                ),
                // 출판년도
                Text(
                  '(출판년도)',
                  style: TextStyle(
                    color: Color(0xFF7C7C7C),
                    fontSize: 15.sp,
                    fontFamily: 'Jua',
                    fontWeight: FontWeight.w400,
                    height: 1.33.h,
                    letterSpacing: -0.23.w,
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                // 태그
                Text(
                  '#작품 #태그 #3개',
                  style: TextStyle(
                    color: Color(0xFF9B9ECF),
                    fontSize: 20.sp,
                    fontFamily: 'Jua',
                    fontWeight: FontWeight.w400,
                    height: 1.h,
                    letterSpacing: -0.23.w,
                  ),
                ),
              ],
            ),
            // 작품 소개글
            Container(
              width: 310.w,
              height: 200.h,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1, color: Color(0xFF9B9ECF)),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 21.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '작품 소개',
                      style: TextStyle(
                        color: Color(0xFF9B9ECF),
                        fontSize: 20.sp,
                        fontFamily: 'Jua',
                        fontWeight: FontWeight.w400,
                        height: 1.h,
                        letterSpacing: -0.23.w,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      '작품 소개글이 들어갈 자리입니다.',
                      style: TextStyle(
                        color: Color(0xFF7C7C7C),
                        fontSize: 15.sp,
                        fontFamily: 'Jua',
                        fontWeight: FontWeight.w400,
                        height: 1.33.h,
                        letterSpacing: -0.23.w,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // 작품 감상 버튼
            GestureDetector(
              onTap: () => controller.toReadPage(title),
              child: Container(
                width: 270.w,
                height: 60.h,
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
                      fontSize: 20.sp,
                      fontFamily: 'Jua',
                      fontWeight: FontWeight.w400,
                      height: 1.h,
                      letterSpacing: -0.23.w,
                    ),
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
