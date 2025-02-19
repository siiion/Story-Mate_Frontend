import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

        // GetStorage에 저장하여 다른 컨트롤러에서도 사용할 수 있도록 함
        box.write("userName", userName.value);
        box.write("userBirth", userBirth.value);
        box.write("messageCount", messageCount.value);

        print(
            "회원 정보 조회 성공: 이름=${userName.value}, 생년월일=${userBirth.value}, 메시지 개수=${messageCount.value}");
      } else {
        print("회원 정보 조회 실패: ${response.body}");
      }
    } catch (e) {
      print("API 오류 발생: $e");
    }
  }

  /// 회원 탈퇴 API 호출
  Future<void> deleteUserAccount() async {
    try {
      // 저장된 accessToken 가져오기
      final prefs = await SharedPreferences.getInstance();
      String? accessToken = prefs.getString('accessToken');

      if (accessToken == null || accessToken.isEmpty) {
        print("Access Token 없음");
        Get.snackbar("오류", "로그인이 필요합니다.",
            backgroundColor: Colors.red, colorText: Colors.white);
        return;
      }

      final response = await http.delete(
        Uri.parse('$baseUrl/member/info'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        // **회원 탈퇴 성공 처리**
        print("회원 탈퇴 성공");

        // 저장된 사용자 데이터 삭제
        await prefs.clear();
        box.erase();

        // 로그아웃 후 회원가입 화면으로 이동
        Get.snackbar("탈퇴 완료", "회원 탈퇴가 완료되었습니다.",
            backgroundColor: Colors.green, colorText: Colors.white);
        Get.offAllNamed('/sign_up'); // 회원가입 화면으로 이동
        // SystemNavigator.pop(); // 화면을 닫음
      } else {
        print("회원 탈퇴 실패: ${response.body}");
        Get.snackbar("실패", "회원 탈퇴에 실패했습니다.",
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      print("API 오류 발생: $e");
      Get.snackbar("오류", "서버와 연결할 수 없습니다.",
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  /// 작품 소개 화면으로 이동
  void toIntroPage(String title) {
    Get.to(BookIntroPage(), arguments: {
      'title': title,
    });
  }
}
