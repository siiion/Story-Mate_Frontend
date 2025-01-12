// 샘플 화면

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storymate/view_models/sample_controller.dart';

class SamplePage extends StatelessWidget {
  const SamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    final SampleController controller =
        Get.put(SampleController()); // controller 연결

    return Scaffold(
      appBar: AppBar(title: Text("Sample App")),
      body: Center(
        child: Obx(() => Text(
              "Count: ${controller.count}",
              style: TextStyle(fontSize: 24),
            )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.increment,
        child: Icon(Icons.add),
      ),
    );
  }
}
