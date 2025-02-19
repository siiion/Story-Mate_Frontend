import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:storymate/views/read/book_intro_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:convert' show utf8; // UTF-8 디코딩을 위해 추가
import 'package:shared_preferences/shared_preferences.dart';

class MyController extends GetxController {
  final box = GetStorage(); // GetStorage 인스턴스 생성
  final String baseUrl = dotenv.env['API_URL']!;

  // 사용자 정보 상태
  var userName = '사용자'.obs;
  var userBirth = '0000.00.00'.obs;
  var messageCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserInfo();
  }

  /// 회원 정보 조회 API 호출
  Future<void> fetchUserInfo() async {
    try {
      // 저장된 accessToken 가져오기
      final prefs = await SharedPreferences.getInstance();
      String? accessToken = prefs.getString('accessToken');

      if (accessToken == null || accessToken.isEmpty) {
        print("Access Token 없음");
        return;
      }

      final response = await http.get(
        Uri.parse('$baseUrl/member/info'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8', // UTF-8 지정
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        // **UTF-8로 디코딩하여 한글 깨짐 방지**
        var decodedBody = utf8.decode(response.bodyBytes);
        var data = json.decode(decodedBody);
        var userData = data["data"];

        // 받은 데이터 적용
        userName.value = userData["nickname"] ?? "사용자";
        userBirth.value = userData["birthDate"] ?? "0000.00.00";
        messageCount.value = userData["messageCount"] ?? 0;

        print(
            "회원 정보 조회 성공: 이름=${userName.value}, 생년월일=${userBirth.value}, 메시지 개수=${messageCount.value}");
      } else {
        print("회원 정보 조회 실패: ${response.body}");
      }
    } catch (e) {
      print("API 오류 발생: $e");
    }
  }

  /// 작품 소개 화면으로 이동
  void toIntroPage(String title) {
    Get.to(BookIntroPage(), arguments: {
      'title': title,
    });
  }
}
