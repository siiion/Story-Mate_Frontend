import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storymate/components/theme.dart';
import 'package:storymate/view_models/mypage/modify_info_controller.dart';

class ModifyInfoPage extends StatelessWidget {
  const ModifyInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ModifyInfoController controller = Get.put(ModifyInfoController());

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        forceMaterialTransparency: true,
        automaticallyImplyLeading: false,
        backgroundColor: AppTheme.backgroundColor,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Icon(Icons.arrow_back_ios_new),
        ),
        centerTitle: true,
        title: Text(
          '내 정보 수정',
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
            fontFamily: 'Jua',
            fontWeight: FontWeight.w400,
            height: 0.80,
            letterSpacing: -0.23,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 0.5,
            color: Color(0xffa2a2a2),
          ),
          Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * 0.4),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '이름 : ',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontFamily: 'Jua',
                          fontWeight: FontWeight.w400,
                          height: 0.80,
                          letterSpacing: -0.23,
                        ),
                      ),
                      Container(
                        width: 190,
                        height: 50,
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                width: 1, color: AppTheme.primaryColor),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Obx(
                            () => TextField(
                              controller: TextEditingController(
                                text: controller.username.value,
                              ),
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                                fontFamily: 'Jua',
                                fontWeight: FontWeight.w400,
                                height: 0.80,
                                letterSpacing: -0.23,
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: controller.username.value.isEmpty
                                    ? '사용자'
                                    : controller.username.value,
                                hintStyle: TextStyle(
                                  color: Color(0xFF7C7C7C),
                                  fontSize: 25,
                                  fontFamily: 'Jua',
                                  fontWeight: FontWeight.w400,
                                  height: 0.80,
                                  letterSpacing: -0.23,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
