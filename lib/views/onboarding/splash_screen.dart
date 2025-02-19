import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storymate/routes/app_routes.dart';
import 'package:storymate/view_models/onboarding/login_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final LoginController loginController = Get.find<LoginController>();

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () async {
      if (await _checkLoginStatus()) {
        Get.offNamed(AppRoutes.HOME); // 로그인 되어 있으면 홈으로 이동
      } else {
        Get.offNamed(AppRoutes.SIGNUP); // 로그인 안 되어 있으면 회원가입 화면으로 이동
      }
    });
  }

  /// 저장된 토큰을 확인하여 로그인 여부 판단
  Future<bool> _checkLoginStatus() async {
    return loginController.accessToken.value.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          'assets/logo.png',
          width: 264,
        ),
      ),
    );
  }
}
