import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // ScreenUtil 임포트
import 'package:get/get.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart'; // dotenv 임포트
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart'; // 카카오 SDK 임포트
import 'package:storymate/view_models/onboarding/login_controller.dart';
import 'routes/app_routes.dart'; // 경로 정의 파일

void main() async {
  await dotenv.load(); // .env 파일 로드
  WidgetsFlutterBinding.ensureInitialized();

  // 카카오 SDK 초기화 (앱 키는 환경 변수에서 불러오기)
  KakaoSdk.init(
    nativeAppKey: '9b800199345edd7cccb05ce7ca02aa57',
  );

  // LoginController를 전역적으로 사용 가능하게 초기화
  Get.put(LoginController());

  // ScreenUtil 초기화는 build() 메소드 내에서 처리합니다.
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // ScreenUtil 초기화 (context 전달)
    ScreenUtil.init(
      context, // 첫 번째 인자: BuildContext
      designSize: Size(375, 812), // 디자인 화면 크기 설정
      minTextAdapt: true,
      splitScreenMode: true,
    );

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'StoryMate',
      initialRoute: _checkLoginStatus()
          ? AppRoutes.HOME
          : AppRoutes.SIGNUP, // 로그인 여부에 따른 초기 화면
      getPages: AppRoutes.routes, // 라우팅 정의
    );
  }

  // 로그인 여부를 체크하는 함수
  bool _checkLoginStatus() {
    final accessToken = Get.find<LoginController>().accessToken.value;
    return accessToken.isNotEmpty; // accessToken이 비어 있지 않으면 로그인 상태
  }
}
