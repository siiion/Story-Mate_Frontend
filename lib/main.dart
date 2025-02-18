import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // ScreenUtil 임포트
import 'package:get/get.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart'; // dotenv 임포트
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart'; // 카카오 SDK 임포트
import 'package:storymate/view_models/onboarding/login_controller.dart';
import 'package:storymate/views/onboarding/splash_screen.dart';
import 'routes/app_routes.dart'; // 경로 정의 파일

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // .env 파일 로드
  await dotenv.load();

  // 환경 변수에서 네이티브 앱 키 가져오기
  String kakaoNativeAppKey = dotenv.env['KAKAO_NATIVE_APP_KEY'] ?? '';

  // 카카오 SDK 초기화 (앱 키는 환경 변수에서 불러오기)
  KakaoSdk.init(
    nativeAppKey: kakaoNativeAppKey,
  );

  // LoginController를 전역적으로 사용 가능하게 초기화
  Get.put(LoginController());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812), // 디자인 화면 크기 설정
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'StoryMate',
          initialRoute: '/', // 스플래쉬 화면을 첫 번째 화면으로 설정
          getPages: [
            GetPage(name: '/', page: () => SplashScreen()), // 스플래쉬 화면 추가
            ...AppRoutes.routes, // 기존 라우트 추가
          ],
        );
      },
    );
  }
}
