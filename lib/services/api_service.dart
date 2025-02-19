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
  Future<bool> refreshAccessToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? refreshToken = prefs.getString('refreshToken');

      if (refreshToken == null) {
        print("리프레시 토큰 없음. 로그아웃 필요.");
        return false;
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

        await saveToken(newAccessToken, refreshToken);
        print("새로운 액세스 토큰 발급 완료!");
        return true; // 토큰 갱신 성공
      } else {
        print("액세스 토큰 재발급 실패: ${response.body}");
        return false; // 토큰 갱신 실패
      }
    } catch (e) {
      print("오류 발생: $e");
      return false; // 토큰 갱신 실패
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
  Future<void> markBookAsRead(int bookId, int progress) async {
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
        body: json.encode({
          "progress": progress,
        }),
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

  /// 메모 추가
  Future<void> addBookNote(int bookId, int position, String content) async {
    try {
      String? accessToken = await getToken();

      if (accessToken == null) {
        print("엑세스 토큰이 없습니다. 로그인이 필요합니다.");
        return;
      }

      final response = await http.post(
        Uri.parse('$baseUrl/api/books/$bookId/notes'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: json.encode({
          "position": position, // 쪽수
          "content": content, // 메모 내용
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("메모 추가 성공! [페이지: $position]");
      } else {
        print("메모 추가 실패: ${response.body}");
      }
    } catch (e) {
      print("메모 추가 중 오류 발생: $e");
    }
  }

  /// 메모 목록 조회
  Future<List<Map<String, dynamic>>> getBookNotes(int bookId) async {
    try {
      String? accessToken = await getToken();

      if (accessToken == null) {
        print("엑세스 토큰이 없습니다. 로그인이 필요합니다.");
        return [];
      }

      final response = await http.get(
        Uri.parse('$baseUrl/api/books/$bookId/notes'),
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        var decodedData =
            json.decode(utf8.decode(response.bodyBytes)); // UTF-8 변환
        print("메모 조회 성공: ${decodedData['data']}");
        return List<Map<String, dynamic>>.from(decodedData['data']);
      } else {
        print("메모 조회 실패: ${response.body}");
        return [];
      }
    } catch (e) {
      print("메모 조회 중 오류 발생: $e");
      return [];
    }
  }

  /// 메모 수정
  Future<void> updateBookNote(int bookId, int noteId, String newContent) async {
    try {
      String? accessToken = await getToken();

      if (accessToken == null) {
        print("엑세스 토큰이 없습니다. 로그인이 필요합니다.");
        return;
      }

      final response = await http.patch(
        Uri.parse('$baseUrl/api/books/$bookId/notes'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: json.encode({
          "noteId": noteId,
          "content": newContent,
        }),
      );

      if (response.statusCode == 200) {
        print("메모 수정 성공! [메모 ID: $noteId]");
      } else {
        print("메모 수정 실패: ${response.body}");
      }
    } catch (e) {
      print("메모 수정 중 오류 발생: $e");
    }
  }

  /// 메모 삭제
  Future<void> deleteBookNote(int bookId, int noteId) async {
    try {
      String? accessToken = await getToken();

      if (accessToken == null) {
        print("엑세스 토큰이 없습니다. 로그인이 필요합니다.");
        return;
      }

      final response = await http.delete(
        Uri.parse('$baseUrl/api/books/$bookId/notes/$noteId'),
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        print("메모 삭제 성공! [메모 ID: $noteId]");
      } else {
        print("메모 삭제 실패: ${response.body}");
      }
    } catch (e) {
      print("메모 삭제 중 오류 발생: $e");
    }
  }

  /// 하이라이트 추가 - 페이지도 추가해야 함
  Future<void> addBookHighlights(int bookId, int page, int startPosition,
      int endPosition, String paragraph) async {
    try {
      String? accessToken = await getToken();

      if (accessToken == null) {
        print("엑세스 토큰이 없습니다. 로그인이 필요합니다.");
        return;
      }

      final response = await http.post(
        Uri.parse('$baseUrl/api/books/$bookId/highlights'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: json.encode({
          "startPosition": startPosition, // 시작 인덱스
          "endPosition": endPosition, // 끝 인덱스
          "paragraph": paragraph, // 하이라이트 내용
          "pageNumber": page, // 하이라이트 시작 쪽수
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("하이라이트 추가 성공! [내용: $paragraph]");
      } else {
        print("하이라이트 추가 실패: ${response.body}");
      }
    } catch (e) {
      print("하이라이트 추가 중 오류 발생: $e");
    }
  }

  /// 하이라이트 목록 조회
  Future<List<Map<String, dynamic>>> getBookHighlights(int bookId) async {
    try {
      String? accessToken = await getToken();

      if (accessToken == null) {
        print("엑세스 토큰이 없습니다. 로그인이 필요합니다.");
        return [];
      }

      final response = await http.get(
        Uri.parse('$baseUrl/api/books/$bookId/highlights'),
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        var decodedData =
            json.decode(utf8.decode(response.bodyBytes)); // UTF-8 변환
        print("하이라이트 조회 성공: ${decodedData['data']}");
        return List<Map<String, dynamic>>.from(decodedData['data']);
      } else {
        print("하이라이트 조회 실패: ${response.body}");
        return [];
      }
    } catch (e) {
      print("하이라이트 조회 중 오류 발생: $e");
      return [];
    }
  }

  /// 하이라이트 삭제
  Future<void> deleteBookHighlights(int bookId, int highlightId) async {
    try {
      String? accessToken = await getToken();

      if (accessToken == null) {
        print("엑세스 토큰이 없습니다. 로그인이 필요합니다.");
        return;
      }

      final response = await http.delete(
        Uri.parse('$baseUrl/api/books/$bookId/highlights/$highlightId'),
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        print("하이라이트 삭제 성공! [하이라이트 ID: $highlightId]");
      } else {
        print("하이라이트 삭제 실패: ${response.body}");
      }
    } catch (e) {
      print("하이라이트 삭제 중 오류 발생: $e");
    }
  }

  /// 책갈피 추가
  Future<void> addBookBookmarks(int bookId, int position) async {
    try {
      String? accessToken = await getToken();

      if (accessToken == null) {
        print("엑세스 토큰이 없습니다. 로그인이 필요합니다.");
        return;
      }

      final response = await http.post(
        Uri.parse('$baseUrl/api/books/$bookId/bookmarks'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: json.encode({
          "position": position, // 쪽수
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("책갈피 추가 성공! [쪽수: $position]");
      } else {
        print("책갈피 추가 실패: ${response.body}");
      }
    } catch (e) {
      print("책갈피 추가 중 오류 발생: $e");
    }
  }

  /// 책갈피  목록 조회
  Future<List<Map<String, dynamic>>> getBookBookmarks(int bookId) async {
    try {
      String? accessToken = await getToken();

      if (accessToken == null) {
        print("엑세스 토큰이 없습니다. 로그인이 필요합니다.");
        return [];
      }

      final response = await http.get(
        Uri.parse('$baseUrl/api/books/$bookId/bookmarks'),
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        var decodedData =
            json.decode(utf8.decode(response.bodyBytes)); // UTF-8 변환
        print("책갈피 조회 성공: ${decodedData['data']}");
        return List<Map<String, dynamic>>.from(decodedData['data']);
      } else {
        print("책갈피 조회 실패: ${response.body}");
        return [];
      }
    } catch (e) {
      print("책갈피 조회 중 오류 발생: $e");
      return [];
    }
  }

  /// 책갈피 삭제
  Future<void> deleteBookBookmarks(int bookId, int bookmarkId) async {
    try {
      String? accessToken = await getToken();

      if (accessToken == null) {
        print("엑세스 토큰이 없습니다. 로그인이 필요합니다.");
        return;
      }

      final response = await http.delete(
        Uri.parse('$baseUrl/api/books/$bookId/bookmarks/$bookmarkId'),
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        print("책갈피 삭제 성공! [책갈피 ID: $bookmarkId]");
      } else {
        print("책갈피 삭제 실패: ${response.body}");
      }
    } catch (e) {
      print("책갈피 삭제 중 오류 발생: $e");
    }
  }
}
