import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storymate/components/theme.dart';
import 'package:storymate/view_models/onboarding/terms_detail_controller.dart';

class TermsDetailPage extends StatefulWidget {
  const TermsDetailPage({super.key});

  @override
  State<TermsDetailPage> createState() => _TermsDetailPageState();
}

class _TermsDetailPageState extends State<TermsDetailPage> {
  final TermsDetailController controller = Get.put(TermsDetailController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        forceMaterialTransparency: true,
        automaticallyImplyLeading: false,
        backgroundColor: AppTheme.backgroundColor,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Icon(Icons.close, color: Colors.black),
        ),
        title: Obx(() => Text(
              controller.title.value,
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontFamily: 'Jua',
                fontWeight: FontWeight.w400,
                height: 1.75,
                letterSpacing: -0.23,
              ),
            )),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Container(
            height: 0.5,
            color: Color(0xffa2a2a2),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(13),
        child: Column(
          children: [
            Obx(() => Text(
                  controller.content.value,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 13,
                    fontFamily: 'Jua',
                    fontWeight: FontWeight.w400,
                    height: 1.54,
                    letterSpacing: -0.23,
                  ),
                )),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      width: 168,
                      height: 55,
                      decoration: ShapeDecoration(
                        color: Color(0xFF9B9ECF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          '비동의 ',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontFamily: 'Jua',
                            fontWeight: FontWeight.w400,
                            height: 1.40,
                            letterSpacing: -0.23,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 13,
                  ),
                  GestureDetector(
                    onTap: () {
                      // 해당 약관 체크
                      controller.agreeToTerms();
                    },
                    child: Container(
                      width: 168,
                      height: 55,
                      decoration: ShapeDecoration(
                        color: Color(0xFF9B9ECF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          '동의',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontFamily: 'Jua',
                            fontWeight: FontWeight.w400,
                            height: 1.40,
                            letterSpacing: -0.23,
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
    );
  }
}
