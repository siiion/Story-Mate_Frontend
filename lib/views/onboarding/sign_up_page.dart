import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storymate/components/theme.dart';
import 'package:storymate/routes/app_routes.dart';
import 'package:storymate/controllers/login_controller.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginExistController loginController =
        Get.put(LoginExistController());

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/logo_only.png', width: 233),
            SizedBox(height: 130),

            //  카카오 로그인 버튼 (함수명 변경)
            GestureDetector(
              onTap: () {
                loginController
                    .loginWithKakao(); //  login() → loginWithKakao() 변경
              },
              child: Image.asset('assets/kakao_signup.png', width: 300),
            ),

            SizedBox(height: 18),

            //  로그인 페이지 이동 버튼
            GestureDetector(
              onTap: () {
                Get.toNamed(AppRoutes.SIGNIN);
              },
              child: Text(
                '이미 계정이 있으신가요?',
                style: TextStyle(
                  color: Color(0xFF7C7C7C),
                  fontSize: 16,
                  fontFamily: 'Jua',
                  fontWeight: FontWeight.w400,
                  decoration: TextDecoration.underline,
                  height: 2.19,
                  letterSpacing: -0.23,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
