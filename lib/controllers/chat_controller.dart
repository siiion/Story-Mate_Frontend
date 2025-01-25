import 'package:get/get.dart';
import '../models/message.dart';

class ChatController extends GetxController {
  var messages = <Message>[].obs; // 메시지 리스트 (Obx로 반응형 처리)
  var messageInput = ''.obs; // 입력값 (반응형 처리)

  // 메시지 추가
  void sendMessage() {
    if (messageInput.value.trim().isNotEmpty) {
      // 사용자 메시지 추가
      messages.add(Message(content: messageInput.value, isUser: true));
      messageInput.value = ''; // 입력값 초기화

      // 간단한 자동 응답 추가
      Future.delayed(Duration(seconds: 1), () {
        messages.add(Message(content: "안녕하세요! 무엇을 도와드릴까요?", isUser: false));
      });
    }
  }
}
