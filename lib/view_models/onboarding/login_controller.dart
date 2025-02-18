import 'package:get/get.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:storymate/routes/app_routes.dart'; // AppRoutes 임포트
import 'package:storymate/services/api_service.dart';

class LoginController extends GetxController {
  final ApiService _apiService = ApiService();
  RxString accessToken = ''.obs;
  RxString userName = ''.obs;
  RxString userBirth = ''.obs;

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

      // 사용자 정보 가져오기 (있는 경우만)
      await fetchUserInfo();

      // 소셜 로그인 API 호출
      await _apiService.socialLogin("kakao", accessTokenValue);

      // 로그인 성공 후 이동
      Get.offAllNamed(
        AppRoutes.INFO,
        arguments: {
          "userName": userName.value,
          "userBirth": userBirth.value,
        },
      ); // AppRoutes.INFO 경로로 이동
    } catch (error) {
      print("카카오 로그인 실패: $error");
    }
  }

  /// 카카오 사용자 정보 가져오기
  Future<void> fetchUserInfo() async {
    try {
      User user = await UserApi.instance.me();

      // 이름이 존재할 경우에만 설정
      if (user.kakaoAccount?.profile?.nickname != null) {
        userName.value = user.kakaoAccount!.profile!.nickname!;
      }

      // 생년월일이 존재할 경우에만 설정
      if (user.kakaoAccount?.birthday != null) {
        userBirth.value = user.kakaoAccount!.birthday!;
      }

      print("사용자 정보: 이름=${userName.value}, 생년월일=${userBirth.value}");
    } catch (error) {
      print("사용자 정보 가져오기 실패: $error");
    }
  }
}
