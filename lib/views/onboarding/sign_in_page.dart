import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storymate/components/theme.dart';
import 'package:storymate/controllers/login_controller.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginExistController loginController =
        Get.put(LoginExistController()); // 로그인 컨트롤러를 GetX로 연결

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo_login.png',
              width: 233,
            ),
            SizedBox(
              height: 76,
            ),
            GestureDetector(
              onTap: () {
                loginController.loginWithKakao(); // 카카오 로그인 버튼을 클릭하면 로그인 처리
              },
              child: Image.asset(
                'assets/kakao_signin.png', // 카카오 로그인 버튼 이미지
                width: 300,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
