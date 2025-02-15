import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart'; // 카카오 SDK 임포트
import 'routes/app_routes.dart'; // 경로 정의 파일
import 'package:storymate/controllers/login_controller.dart'; // 로그인 컨트롤러

void main() async {
  await dotenv.load(); // .env 파일 로드
  WidgetsFlutterBinding.ensureInitialized();
  // 카카오 SDK 초기화
  KakaoSdk.init(
    nativeAppKey: '9b800199345edd7cccb05ce7ca02aa57',
  );

  // LoginController를 전역적으로 사용 가능하게 초기화
  Get.put(LoginExistController());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
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
    // LoginController에서 accessToken을 확인하여 로그인 상태를 판단
    final accessToken = Get.find<LoginExistController>().accessToken.value;
    return accessToken.isNotEmpty; // accessToken이 비어 있지 않으면 로그인 상태
  }
}
