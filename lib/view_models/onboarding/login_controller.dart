import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:storymate/routes/app_routes.dart';
import 'package:storymate/services/api_service.dart';

class LoginController extends GetxController {
  final ApiService _apiService = ApiService();

  RxString accessToken = ''.obs;
  RxString userName = ''.obs;
  RxString userBirth = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _loadStoredToken(); // 저장된 토큰 불러오기
  }

  /// 저장된 토큰 불러오기
  Future<void> _loadStoredToken() async {
    final prefs = await SharedPreferences.getInstance();
    String? storedToken = prefs.getString('accessToken');

    if (storedToken != null && storedToken.isNotEmpty) {
      accessToken.value = storedToken;
      print("저장된 액세스 토큰 로드: $storedToken");
    } else {
      print("저장된 액세스 토큰 없음");
    }
  }

  /// 카카오 로그인 처리
  Future<void> loginWithKakao({required bool isSignUp}) async {
    try {
      OAuthToken token;
      if (await isKakaoTalkInstalled()) {
        token = await UserApi.instance.loginWithKakaoTalk();
      } else {
        token = await UserApi.instance.loginWithKakaoAccount();
      }

      String accessTokenValue = token.accessToken;
      print("카카오 로그인 성공, accessToken: $accessTokenValue");

      await fetchUserInfo();

      await _apiService.socialLogin("kakao", accessTokenValue);

      // 저장된 토큰 다시 로드
      await _loadStoredToken();

      // 로그인 후 이동 로직
      if (isSignUp) {
        Get.offAllNamed(AppRoutes.INFO, arguments: {
          "userName": userName.value,
          "userBirth": userBirth.value,
        });
      } else {
        Get.offAllNamed(AppRoutes.HOME); // 로그인 화면에서 호출 시 홈으로 이동
      }
    } catch (error) {
      print("카카오 로그인 실패: $error");
    }
  }

  /// 사용자 정보 불러오기
  Future<void> fetchUserInfo() async {
    try {
      User user = await UserApi.instance.me();

      if (user.kakaoAccount?.profile?.nickname != null) {
        userName.value = user.kakaoAccount!.profile!.nickname!;
      }

      if (user.kakaoAccount?.birthday != null) {
        userBirth.value = user.kakaoAccount!.birthday!;
      }

      print("사용자 정보: 이름=${userName.value}, 생년월일=${userBirth.value}");
    } catch (error) {
      print("사용자 정보 가져오기 실패: $error");
    }
  }

  /// 로그아웃 (토큰 삭제)
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('accessToken');
    await prefs.remove('refreshToken');

    accessToken.value = ''; // 상태값 초기화
    userName.value = '';
    userBirth.value = '';

    print("로그아웃 완료, 저장된 토큰 삭제됨");
    Get.offAllNamed(AppRoutes.SIGNUP); // 로그인 화면으로 이동
  }
}
