import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/chat_controller.dart';
import 'package:storymate/views/chat/chat_bubble.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ChatController controller =
        Get.put(ChatController()); // controller 연결

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("대화하기"),
        backgroundColor: Color(0xFF9B9FD0), // AppBar 색상
        centerTitle: true,
      ),
      body: Column(
        children: [
          // 채팅 메시지 리스트
          Expanded(
            child: Obx(() => ListView.builder(
                  reverse: true,
                  itemCount: controller.messages.length,
                  itemBuilder: (context, index) {
                    final message =
                        controller.messages.reversed.toList()[index];
                    return ChatBubble(message: message); // 메시지 UI
                  },
                )),
          ),
          // 입력창
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Obx(
                    () => TextField(
                      onChanged: (value) =>
                          controller.messageInput.value = value,
                      decoration: InputDecoration(
                        hintText: '메시지를 입력하세요',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Color(0xFF9B9FD0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              BorderSide(color: Color(0xFF9B9FD0), width: 2.0),
                        ),
                      ),
                      controller: TextEditingController()
                        ..text = controller.messageInput.value
                        ..selection = TextSelection.fromPosition(
                          TextPosition(
                              offset: controller.messageInput.value.length),
                        ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send, color: Color(0xFF9B9FD0)),
                  onPressed: controller.sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
