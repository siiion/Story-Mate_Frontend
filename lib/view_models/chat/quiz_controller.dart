import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:storymate/services/api_service.dart';

class QuizController extends GetxController {
  final ApiService apiService = ApiService();

  var quizList = <Map<String, dynamic>>[].obs; // 모든 퀴즈 데이터 저장
  var currentQuizIndex = 0.obs; // 현재 퀴즈 인덱스
  var isLoading = true.obs;
  var isSubmitting = false.obs;

  String characterName = "";
  String bookTitle = "";

  var question = "".obs; // Rx 변수로 변경
  var quizType = "".obs; // Rx 변수로 변경

  int oxAnswer = -1;
  int mcqAnswer = -1;
  TextEditingController essayController = TextEditingController();

  @override
  void onInit() {
    super.onInit();

    if (Get.arguments != null) {
      characterName = Get.arguments["characterName"] ?? "";
      bookTitle = Get.arguments["bookTitle"] ?? "";
    } else {
      characterName = "UnknownCharacter";
      bookTitle = "UnknownBook";
    }

    fetchAllQuizzes();
  }

  // 모든 퀴즈 데이터 요청
  Future<void> fetchAllQuizzes() async {
    isLoading.value = true;

    List<String> quizTypes = ["ox", "multiple_choice", "essay"];

    for (String type in quizTypes) {
      var data = await apiService.fetchQuizData(characterName, bookTitle, type);
      if (data != null) {
        Map<String, dynamic>? quizData = data["data"];
        if (quizData != null) {
          quizList.add({
            "type": type,
            "question": quizData["quiz"],
          });
          print("추가된 퀴즈 데이터: ${quizData["quiz"]} | 유형: $type");
        } else {
          print("서버에서 해당 유형의 퀴즈 데이터를 받지 못했습니다: $type");
        }
      }
    }

    print("전체 퀴즈 데이터 목록: $quizList");

    if (quizList.isNotEmpty) {
      updateCurrentQuiz();
    }

    isLoading.value = false;
  }

  // 현재 퀴즈 설정
  void updateCurrentQuiz() {
    if (quizList.isNotEmpty && currentQuizIndex.value < quizList.length) {
      var currentQuiz = quizList[currentQuizIndex.value];
      question.value = currentQuiz["question"];
      quizType.value = currentQuiz["type"];

      print(
          "현재 문제 설정 완료: 인덱스 = ${currentQuizIndex.value}, 문제 = $question, 유형 = $quizType");

      oxAnswer = -1;
      mcqAnswer = -1;
      essayController.clear();
    } else {
      print(
          "문제를 불러오는 데 실패했습니다. 인덱스: ${currentQuizIndex.value}, 전체 퀴즈 수: ${quizList.length}");
    }
  }

  // 퀴즈 제출 및 결과 확인
  Future<void> submitQuiz(BuildContext context) async {
    if (isSubmitting.value) return;

    isSubmitting.value = true;

    String userAnswer = "";
    if (quizType == "ox") {
      userAnswer = oxAnswer == 1 ? "O" : "X";
    } else if (quizType == "multiple_choice") {
      userAnswer = mcqAnswer.toString();
    } else {
      userAnswer = essayController.text;
    }

    // 서버로 답안 제출 (GET 요청 유지)
    var response = await apiService.submitQuizAnswer(
        characterName, bookTitle, quizType.value, userAnswer);

    if (response != null) {
      print("서버 응답 전체 데이터: $response");

      String resultMessage = response["data"]?.toString() ?? "응답 데이터가 없습니다.";

      showResultDialog(context, resultMessage);
    } else {
      print("퀴즈 제출 실패");
    }

    isSubmitting.value = false;
  }

  // 다음 퀴즈로 이동
  void moveToNextQuiz(BuildContext context) {
    if (currentQuizIndex.value < quizList.length - 1) {
      currentQuizIndex.value++;
      print("다음 퀴즈로 이동: 현재 인덱스 = ${currentQuizIndex.value}");
      updateCurrentQuiz();
    } else {
      print("모든 퀴즈 완료: 전체 퀴즈 수 = ${quizList.length}");
      Get.defaultDialog(
        title: "퀴즈 완료!",
        middleText: "모든 퀴즈를 완료했습니다!",
        textConfirm: "종료",
        onConfirm: () {
          Get.back(); // 다이얼로그 닫기
          Get.back(); // 이전 화면으로 돌아가기
        },
      );
    }
  }

  // 결과 다이얼로그
  void showResultDialog(BuildContext context, String message) {
    Get.defaultDialog(
      title: "퀴즈 결과",
      middleText: message,
      textConfirm: "다음 문제로",
      onConfirm: () {
        Get.back();
        moveToNextQuiz(context);
      },
    );
  }
}
