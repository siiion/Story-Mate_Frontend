import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storymate/components/theme.dart';
import 'package:storymate/view_models/onboarding/info_controller.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({super.key});

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  final InfoController controller = Get.put(InfoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppTheme.backgroundColor,
        title: Text(
          '내 정보 등록',
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
            fontFamily: 'Jua',
            fontWeight: FontWeight.w400,
            height: 0.80,
            letterSpacing: -0.23,
          ),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Container(
            height: 0.5,
            color: Color(0xffa2a2a2),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
                        side:
                            BorderSide(width: 1, color: AppTheme.primaryColor),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 13),
                      child: Text(
                        '사용자', // 카카오에서 받아온 사용자 이름
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
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '생년월일 : ',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontFamily: 'Jua',
                    fontWeight: FontWeight.w400,
                    height: 0.80,
                    letterSpacing: -0.23,
                  ),
                ),
                GestureDetector(
                  onTap: () => controller.selectDate(context), // 날짜 선택
                  child: Container(
                    width: 190,
                    height: 50,
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        side:
                            BorderSide(width: 1, color: AppTheme.primaryColor),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 13),
                      child: Obx(
                        () => Text(
                          controller.getFormattedDate(), // 선택된 날짜 표시
                          style: TextStyle(
                            color: controller.selectedDate.value != null
                                ? Colors.black
                                : Color(0xFF7C7C7C),
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
            SizedBox(height: 20),
            Container(
              width: 164,
              height: 50,
              decoration: ShapeDecoration(
                color: AppTheme.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: GestureDetector(
                onTap: () {}, // 정보 저장 로직
                child: Center(
                  child: Text(
                    '등록하기',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontFamily: 'Jua',
                      fontWeight: FontWeight.w400,
                      letterSpacing: -0.23,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
