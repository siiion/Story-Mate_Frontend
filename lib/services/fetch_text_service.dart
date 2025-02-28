// 서버로부터 작품 txt 파일을 받아오는 함수

import 'package:http/http.dart' as http;

Future<String> fetchTextFile(String url) async {
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    return response.body; // 텍스트 데이터 반환
  } else {
    throw Exception('Failed to load text file');
  }
}
