import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ApiService {
  final String baseUrl = "https://be.dev.storymate.site"; // 서버 URL 설정

  // 로그인 후 토큰 발급
  Future<void> getTokens(String provider, String authCode) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/$provider/token'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({"authCode": authCode}),
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        String accessToken = data["accessToken"];
        String refreshToken = data["refreshToken"];

        // 토큰을 SharedPreferences에 저장
        await saveToken(accessToken, refreshToken);

        print("토큰 저장 완료!");
      } else {
        print("토큰 발급 실패: ${response.body}");
      }
    } catch (e) {
      print("오류 발생: $e");
    }
  }

  // 액세스 토큰 재발급
  Future<void> refreshAccessToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? refreshToken = prefs.getString('refreshToken');

      if (refreshToken == null) {
        print("리프레시 토큰 없음");
        return;
      }

      final response = await http.post(
        Uri.parse('$baseUrl/auth/reissue'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({"refreshToken": refreshToken}),
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        String newAccessToken = data["accessToken"];
        await saveToken(newAccessToken, refreshToken); // 새로운 액세스 토큰 저장
        print("새로운 액세스 토큰 발급!");
      } else {
        print("액세스 토큰 재발급 실패: ${response.body}");
      }
    } catch (e) {
      print("오류 발생: $e");
    }
  }

  // 카카오 로그인 후 토큰 발급 요청
  Future<void> socialLogin(String provider, String token) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/social-login/$provider'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          "token": token, // 서버에서 기대하는 대로 'token' 파라미터를 전달
        }),
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        String accessToken = data["accessToken"];
        String refreshToken = data["refreshToken"];

        // 토큰을 SharedPreferences에 저장
        await saveToken(accessToken, refreshToken);

        print("소셜 로그인 후 토큰 저장 완료!");
      } else {
        print("소셜 로그인 실패: ${response.body}");
      }
    } catch (e) {
      print("소셜 로그인 중 오류 발생: $e");
    }
  }

  // 토큰을 SharedPreferences에 저장하는 함수
  Future<void> saveToken(String accessToken, String refreshToken) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('accessToken', accessToken); // accessToken 저장
      await prefs.setString('refreshToken', refreshToken); // refreshToken 저장
      print("토큰 저장 성공: $accessToken, $refreshToken");
    } catch (e) {
      print("토큰 저장 중 오류 발생: $e");
    }
  }

  // 토큰을 SharedPreferences에서 불러오는 함수
  Future<String?> getToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('accessToken');
      if (token == null) {
        print("토큰이 없습니다.");
        return null;
      }
      print("불러온 토큰: $token");
      return token;
    } catch (e) {
      print("토큰 불러오기 중 오류 발생: $e");
      return null;
    }
  }

  // 리프레시 토큰을 SharedPreferences에서 불러오는 함수
  Future<String?> getRefreshToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? refreshToken = prefs.getString('refreshToken');
      print("불러온 리프레시 토큰: $refreshToken");
      return refreshToken;
    } catch (e) {
      print("리프레시 토큰 불러오기 중 오류 발생: $e");
      return null;
    }
  }

  // 저장된 토큰 삭제 함수
  Future<void> deleteToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('accessToken');
      await prefs.remove('refreshToken');
      print("토큰 삭제 완료!");
    } catch (e) {
      print("토큰 삭제 중 오류 발생: $e");
    }
  }

  // 작품을 읽음으로 표시하는 메서드
  Future<void> markBookAsRead(int bookId) async {
    try {
      String? accessToken = await getToken(); // 저장된 액세스 토큰 가져오기

      if (accessToken == null) {
        print("엑세스 토큰이 없습니다. 로그인이 필요합니다.");
        return;
      }

      final response = await http.put(
        Uri.parse('$baseUrl/api/books/$bookId/contents'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        print("책 ID: $bookId 읽음 표시 성공!");
      } else {
        print("책 ID: $bookId 읽음 표시 실패: ${response.body}");
      }
    } catch (e) {
      print("책 ID: $bookId 읽음 표시 중 오류 발생: $e");
    }
  }
}
