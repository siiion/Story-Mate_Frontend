import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:storymate/components/theme.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo_login.png',
              width: 233.w,
            ),
            SizedBox(
              height: 76.h,
            ),
            Image.asset(
              'assets/kakao_signin.png',
              width: 300.w,
            ),
          ],
        ),
      ),
    );
  }
}
