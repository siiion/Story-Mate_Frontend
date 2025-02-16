import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../models/message.dart';

class ChatController extends GetxController {
  var messages = <Message>[].obs; // 메시지 리스트 (Obx로 반응형 처리)
  var messageInput = ''.obs; // 입력값 (반응형 처리)
  late TextEditingController textController; // 🔹 수정: late로 선언

  @override
  void onInit() {
    super.onInit();
    textController = TextEditingController(); // 초기화
  }

  // 메시지 추가
  void sendMessage() {
    if (textController.text.trim().isNotEmpty) {
      // 사용자 메시지 추가
      messages.add(Message(content: textController.text, isUser: true));
      textController.clear(); // 입력창 초기화

      // 간단한 자동 응답 추가
      Future.delayed(Duration(seconds: 1), () {
        messages.add(Message(content: "안녕하세요! 무엇을 도와드릴까요?", isUser: false));
      });
    }
  }

  @override
  void onClose() {
    textController.dispose(); // 텍스트 컨트롤러 메모리 해제
    super.onClose(); // 부모 클래스의 onClose 호출
  }
}
