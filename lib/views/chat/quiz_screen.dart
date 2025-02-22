import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storymate/view_models/chat/quiz_controller.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final QuizController controller = Get.put(QuizController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(title: Text("퀴즈 풀기")),
        body: Obx(() {
          if (controller.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          }

          var quizType = controller.quizType.value;
          var question = controller.question.value;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "문제: $question",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  _buildQuizInput(quizType),
                  SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        controller.submitQuiz(context);
                      },
                      child: Text("제출하기"),
                    ),
                  )
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildQuizInput(String quizType) {
    switch (quizType) {
      case "ox":
        return _buildOXQuiz();
      case "multiple_choice":
        return _buildMultipleChoiceQuiz();
      case "essay":
        return _buildEssayQuiz();
      default:
        return Text("지원하지 않는 퀴즈 형식입니다.");
    }
  }

  Widget _buildOXQuiz() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () => setState(() => controller.oxAnswer = 1),
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  controller.oxAnswer == 1 ? Colors.green : Colors.grey,
            ),
            child: Text("O"),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: ElevatedButton(
            onPressed: () => setState(() => controller.oxAnswer = 0),
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  controller.oxAnswer == 0 ? Colors.red : Colors.grey,
            ),
            child: Text("X"),
          ),
        ),
      ],
    );
  }

  Widget _buildMultipleChoiceQuiz() {
    List<String> options = [
      "1. 선택지 A",
      "2. 선택지 B",
      "3. 선택지 C",
      "4. 선택지 D"
    ]; // 실제 데이터로 대체 예정

    return Column(
      children: List.generate(options.length, (index) {
        return RadioListTile<int>(
          title: Text(options[index]),
          value: index,
          groupValue: controller.mcqAnswer,
          onChanged: (value) => setState(() => controller.mcqAnswer = value!),
        );
      }),
    );
  }

  Widget _buildEssayQuiz() {
    return TextField(
      controller: controller.essayController,
      decoration: InputDecoration(
        hintText: "정답을 입력하세요",
        border: OutlineInputBorder(),
      ),
      maxLines: 5,
    );
  }
}
