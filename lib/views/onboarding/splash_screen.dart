import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:storymate/routes/app_routes.dart';
import 'package:storymate/view_models/onboarding/login_controller.dart'; // 경로 정의

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // 2초 후 로그인 상태 확인 후 이동
    Future.delayed(Duration(seconds: 2), () {
      if (_checkLoginStatus()) {
        Get.offNamed(AppRoutes.HOME); // 로그인 되어 있으면 홈으로 이동
      } else {
        Get.offNamed(AppRoutes.SIGNUP); // 로그인 안 되어 있으면 회원가입 화면으로 이동
      }
    });
  }

  // 로그인 여부를 체크하는 함수
  bool _checkLoginStatus() {
    final accessToken = Get.find<LoginController>().accessToken.value;
    return accessToken.isNotEmpty; // accessToken이 비어 있지 않으면 로그인 상태
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // 배경색 설정
      body: Center(
        child: Image.asset(
          'assets/logo.png', // 스플래쉬 로고 이미지
          width: 264.w, // 반응형 적용
        ),
      ),
    );
  }
}
