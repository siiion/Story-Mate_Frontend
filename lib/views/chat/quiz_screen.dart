import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:storymate/components/theme.dart';
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
      onWillPop: () async {
        // 뒤로 가기 시 다이얼로그 띄우기
        bool shouldExit = await _showExitConfirmationDialog(context);
        return shouldExit;
      },
      child: Scaffold(
        backgroundColor: AppTheme.backgroundColor,
        appBar: AppBar(
            forceMaterialTransparency: true,
            title: Text(
              "퀴즈 풀기",
              style: TextStyle(fontFamily: 'Jua'),
            )),
        body: Obx(() {
          if (controller.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          }

          var quizType = controller.quizType.value;
          var question = controller.question.value;

          if (quizType == "multiple_choice") {
            question = question.split('1.')[0].trim();
          }

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 32.h),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "문제: $question",
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontFamily: 'Jua',
                    ),
                  ),
                  SizedBox(height: 30.h),
                  _buildQuizInput(quizType),
                  SizedBox(height: 30.h),
                  // 제출 버튼 및 로딩바
                  Center(
                    child: controller.isEssaySubmitting.value
                        ? CircularProgressIndicator() // 로딩 중 원형 로딩바 표시
                        : Obx(
                            () => ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: controller.isAnswerProvided
                                    ? AppTheme.primaryColor
                                    : Colors.grey, // 답변이 없으면 버튼 비활성화 색상 적용
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20.w, vertical: 10.h),
                              ),
                              onPressed: controller.isAnswerProvided
                                  ? () {
                                      controller.submitQuiz(context);
                                    }
                                  : null, // 답변이 없으면 버튼 비활성화
                              child: Text(
                                "제출하기",
                                style: TextStyle(
                                  fontFamily: 'Jua',
                                  color: Colors.white,
                                  fontSize: 20.sp,
                                ),
                              ),
                            ),
                          ),
                  ),
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
            child: Text(
              "O",
              style: TextStyle(
                fontFamily: 'Jua',
                color: Colors.white,
                fontSize: 20.sp,
              ),
            ),
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
            child: Text(
              "X",
              style: TextStyle(
                fontFamily: 'Jua',
                color: Colors.white,
                fontSize: 20.sp,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMultipleChoiceQuiz() {
    // 문제에서 선지를 추출
    String fullQuestion = controller.question.value;
    List<String> options = controller.parseOptionsFromQuestion(fullQuestion);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 선지 출력
        ...List.generate(options.length, (index) {
          bool isSelected = controller.mcqAnswer == index;

          return GestureDetector(
            onTap: () {
              setState(() {
                controller.mcqAnswer = index; // 선택한 선지 인덱스 업데이트
              });
            },
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 8.h),
              padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected ? AppTheme.primaryColor : Colors.grey,
                  width: 2,
                ),
                color: isSelected
                    ? AppTheme.primaryColor.withOpacity(0.1)
                    : Colors.white,
              ),
              child: Text(
                '${index + 1}. ${options[index]}',
                style: TextStyle(
                  fontFamily: 'Jua',
                  fontSize: 18.sp,
                  color: isSelected ? AppTheme.primaryColor : Colors.black,
                ),
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildEssayQuiz() {
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 에세이 입력 필드
          TextField(
            controller: controller.essayController,
            decoration: InputDecoration(
              hintText: "정답을 입력하세요",
              border: OutlineInputBorder(),
            ),
            maxLines: 5,
            enabled: !controller.isEssaySubmitting.value, // 제출 중 입력 비활성화
            onChanged: (value) {
              controller.essayAnswer.value = value; // 실시간 입력값 업데이트
            },
          ),

          SizedBox(height: 15.h),

          // 서버 응답 메시지 출력
          if (controller.essayResponse.isNotEmpty)
            Container(
              margin: EdgeInsets.only(top: 20.h),
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 말풍선 아이콘
                  Icon(
                    Icons.chat_bubble_outline,
                    color: AppTheme.primaryColor,
                    size: 24.sp,
                  ),
                  SizedBox(width: 10.w),
                  // 응답 텍스트
                  Expanded(
                    child: Text(
                      controller.essayResponse.value,
                      style: TextStyle(
                        fontFamily: 'Jua',
                        fontSize: 16.sp,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      );
    });
  }
}

Future<bool> _showExitConfirmationDialog(BuildContext context) async {
  bool shouldExit = false;

  await Get.dialog(
    Dialog(
      backgroundColor: AppTheme.backgroundColor, // 다이얼로그 배경색 설정
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20), // 모서리 둥글게
      ),
      child: Padding(
        padding: EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 타이틀
            Text(
              "퀴즈 풀이를 중단하시겠습니까?",
              style: TextStyle(
                fontFamily: 'Jua',
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 20.h), // 타이틀과 설명 간 간격

            // 중간 설명 텍스트
            Text(
              "중단 시 대화 화면으로 돌아갑니다.",
              style: TextStyle(
                fontFamily: 'Jua',
                fontSize: 16.sp,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 30.h), // 설명과 버튼 간 간격

            // 버튼 그룹
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // 계속하기 버튼
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      shouldExit = false;
                      Get.back(); // 다이얼로그 닫기
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[400], // 버튼 색상
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      "계속하기",
                      style: TextStyle(
                        fontFamily: 'Jua',
                        fontSize: 18.sp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16.w), // 버튼 간 간격

                // 중단하기 버튼
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      shouldExit = true;
                      Get.back(); // 다이얼로그 닫기
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryColor,
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      "중단하기",
                      style: TextStyle(
                        fontFamily: 'Jua',
                        fontSize: 18.sp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
    barrierDismissible: false, // 다이얼로그 외부 클릭 시 닫히지 않도록 설정
  );

  return shouldExit;
}
