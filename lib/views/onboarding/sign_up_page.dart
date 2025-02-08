import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:storymate/components/theme.dart';
import 'package:storymate/routes/app_routes.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo_only.png',
              width: 233.w,
            ),
            SizedBox(
              height: 130.h,
            ),
            // 카카오로 시작하기 버튼
            GestureDetector(
              onTap: () {},
              child: Image.asset(
                'assets/kakao_signup.png',
                width: 300.w,
              ),
            ),
            SizedBox(
              height: 18.h,
            ),
            GestureDetector(
              onTap: () {
                Get.toNamed(AppRoutes.SIGNIN);
              }, // 로그인 화면으로 이동
              child: Text(
                '이미 계정이 있으신가요?',
                style: TextStyle(
                  color: Color(0xFF7C7C7C),
                  fontSize: 16.sp,
                  fontFamily: 'Jua',
                  fontWeight: FontWeight.w400,
                  decoration: TextDecoration.underline,
                  height: 2.19.h,
                  letterSpacing: -0.23.w,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
