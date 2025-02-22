import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  Map<String, dynamic>? quizData;
  String characterName = ""; // 캐릭터 이름
  String bookTitle = ""; // 책 제목
  String quizType = ""; // OX, 객관식, 서술형 중 선택 가능

  int oxAnswer = -1;
  int mcqAnswer = -1;
  TextEditingController essayController = TextEditingController();

  bool isLoading = true;
  bool isSubmitting = false;

  @override
  void initState() {
    super.initState();
    fetchQuizData();
  }

  // 서버에서 퀴즈 데이터 가져오기
  Future<void> fetchQuizData() async {
    setState(() => isLoading = true);

    final requestBody = json.encode({
      "characterName": characterName,
      "bookTitle": bookTitle,
      "quizType": quizType
    });

    print(" 요청 데이터: $requestBody"); // 요청 데이터 출력

    try {
      final response = await http.post(
        Uri.parse('https://your-server.com/api/quiz/question'),
        headers: {"Content-Type": "application/json"},
        body: requestBody,
      );

      print(" 응답 코드: ${response.statusCode}");
      print(" 응답 본문: ${response.body}");

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        setState(() {
          quizData = responseData["data"];
          isLoading = false;
        });
      } else {
        print(" 퀴즈 로딩 실패: ${response.statusCode}, ${response.body}");
        setState(() => isLoading = false);
      }
    } catch (e) {
      print(" 퀴즈 가져오기 오류: $e");
      setState(() => isLoading = false);
    }
  }

  // 퀴즈 제출 (서버로 답변 전송)
  Future<void> submitQuiz() async {
    if (isSubmitting) return;
    setState(() => isSubmitting = true);

    String userAnswer;
    if (quizType == "OX") {
      userAnswer = oxAnswer == 1 ? "O" : "X";
    } else if (quizType == "객관식") {
      userAnswer = mcqAnswer.toString();
    } else {
      userAnswer = essayController.text;
    }

    try {
      final response = await http.post(
        Uri.parse('https://your-server.com/api/quiz/answer'),
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          "bookTitle": bookTitle,
          "characterName": characterName,
          "quizType": quizType,
          "userAnswer": userAnswer,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        showResultDialog(responseData["data"]["response"]);
      } else {
        print("퀴즈 제출 실패: ${response.statusCode}");
      }
    } catch (e) {
      print("퀴즈 제출 오류: $e");
    } finally {
      setState(() => isSubmitting = false);
    }
  }

  // 퀴즈 결과 다이얼로그 표시
  void showResultDialog(String message) {
    Get.defaultDialog(
      title: "퀴즈 완료!",
      middleText: message,
      textConfirm: "채팅으로 돌아가기",
      onConfirm: () {
        Get.back();
        Get.back();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(title: Text("퀴즈")),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("퀴즈: ${quizData!["quiz"]}",
                        style: TextStyle(fontSize: 18)),
                    if (quizType == "OX") ...[
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () => setState(() => oxAnswer = 1),
                              child: Text("O"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    oxAnswer == 1 ? Colors.green : Colors.grey,
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () => setState(() => oxAnswer = 0),
                              child: Text("X"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    oxAnswer == 0 ? Colors.red : Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ] else if (quizType == "객관식") ...[
                      Column(
                        children: List.generate(4, (index) {
                          return RadioListTile<int>(
                            title: Text("객관식 선택지 $index"), // 실제 데이터 반영 필요
                            value: index,
                            groupValue: mcqAnswer,
                            onChanged: (value) =>
                                setState(() => mcqAnswer = value!),
                          );
                        }),
                      ),
                    ] else ...[
                      TextField(
                        controller: essayController,
                        decoration: InputDecoration(hintText: "답을 입력하세요"),
                      ),
                    ],
                    SizedBox(height: 20),
                    Center(
                      child: ElevatedButton(
                        onPressed: isSubmitting ? null : submitQuiz,
                        child: isSubmitting
                            ? CircularProgressIndicator()
                            : Text("퀴즈 제출"),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
