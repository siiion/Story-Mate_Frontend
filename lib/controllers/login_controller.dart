import 'package:get/get.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:storymate/routes/app_routes.dart'; // AppRoutes 임포트
import '../services/api_service.dart';

class LoginExistController extends GetxController {
  final ApiService _apiService = ApiService();
  RxString accessToken = ''.obs;

  Future<void> loginWithKakao() async {
    try {
      // 카카오톡으로 로그인
      OAuthToken token;
      if (await isKakaoTalkInstalled()) {
        token = await UserApi.instance
            .loginWithKakaoTalk(); // 이 부분이 Future<OAuthToken> 반환
      } else {
        token = await UserApi.instance
            .loginWithKakaoAccount(); // 이 부분도 Future<OAuthToken> 반환
      }

      // OAuthToken에서 accessToken 추출
      String accessTokenValue = token.accessToken;

      print("카카오 로그인 성공, accessToken: $accessTokenValue");

      // 소셜 로그인 API 호출
      await _apiService.socialLogin("kakao", accessTokenValue);

      // 로그인 성공 후 이동
      Get.offAllNamed(AppRoutes.INFO); // AppRoutes.INFO 경로로 이동
    } catch (error) {
      print("카카오 로그인 실패: $error");
    }
  }
}
