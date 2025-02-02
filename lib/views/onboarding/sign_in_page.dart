import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
              width: 233,
            ),
            SizedBox(
              height: 76,
            ),
            Image.asset(
              'assets/kakao_signin.png',
              width: 300,
            ),
          ],
        ),
      ),
    );
  }
}
