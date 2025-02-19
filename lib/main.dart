import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:storymate/view_models/onboarding/login_controller.dart';
import 'package:storymate/views/onboarding/splash_screen.dart';
import 'routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  await dotenv.load();
  String kakaoNativeAppKey = dotenv.env['KAKAO_NATIVE_APP_KEY'] ?? '';
  KakaoSdk.init(nativeAppKey: kakaoNativeAppKey);

  // LoginController를 전역으로 등록
  Get.put(LoginController());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'StoryMate',
          initialRoute: '/', // 스플래쉬 화면이 첫 화면
          getPages: [
            GetPage(name: '/', page: () => SplashScreen()), // 자동 로그인 체크
            ...AppRoutes.routes,
          ],
        );
      },
    );
  }
}
