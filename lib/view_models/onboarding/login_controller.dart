import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:storymate/routes/app_routes.dart';
import 'package:storymate/services/api_service.dart';

class LoginController extends GetxController {
  final ApiService _apiService = ApiService();
  final box = GetStorage(); // GetStorage 인스턴스 생성

  RxString accessToken = ''.obs;
  RxString userName = ''.obs;
  RxString userBirth = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // 저장된 사용자 정보 불러오기
    userName.value = box.read("userName") ?? "";
    userBirth.value = box.read("userBirth") ?? "";
  }

  Future<void> loginWithKakao() async {
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

      // 로그인 성공 후 이동
      Get.offAllNamed(AppRoutes.INFO, arguments: {
        "userName": userName.value,
        "userBirth": userBirth.value,
      });
    } catch (error) {
      print("카카오 로그인 실패: $error");
    }
  }

  Future<void> fetchUserInfo() async {
    try {
      User user = await UserApi.instance.me();

      if (user.kakaoAccount?.profile?.nickname != null) {
        userName.value = user.kakaoAccount!.profile!.nickname!;
        box.write("userName", userName.value); // 이름 저장
      }

      if (user.kakaoAccount?.birthday != null) {
        userBirth.value = user.kakaoAccount!.birthday!;
        box.write("userBirth", userBirth.value); // 생년월일 저장
      }

      print("사용자 정보: 이름=${userName.value}, 생년월일=${userBirth.value}");
    } catch (error) {
      print("사용자 정보 가져오기 실패: $error");
    }
  }
}
