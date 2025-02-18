import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  void initState() {
    super.initState();

    // arguments에서 사용자 정보 가져오기
    final arguments = Get.arguments ?? {};
    String userName = arguments["userName"] ?? "사용자"; // 기본값 "사용자"
    String userBirth =
        arguments["userBirth"] ?? "0000.00.00"; // 기본값 "0000.00.00"

    // InfoController에 초기값 설정
    controller.setInitialInfo(userName, userBirth);
  }

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
            fontSize: 25.sp,
            fontFamily: 'Jua',
            fontWeight: FontWeight.w400,
            height: 0.80.h,
            letterSpacing: -0.23.w,
          ),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0.h),
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
              padding: EdgeInsets.only(left: 40.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '이름 : ',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 25.sp,
                      fontFamily: 'Jua',
                      fontWeight: FontWeight.w400,
                      height: 0.80.h,
                      letterSpacing: -0.23.w,
                    ),
                  ),
                  Container(
                    width: 190.w,
                    height: 50.h,
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        side:
                            BorderSide(width: 1, color: AppTheme.primaryColor),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      child: TextField(
                        controller: controller.nameController, // 텍스트 필드 컨트롤러 적용
                        onChanged: (value) =>
                            controller.userName.value = value, // 값 변경 시 업데이트
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 22.sp,
                          fontFamily: 'Jua',
                          fontWeight: FontWeight.w400,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '생년월일 : ',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25.sp,
                    fontFamily: 'Jua',
                    fontWeight: FontWeight.w400,
                    height: 0.80.h,
                    letterSpacing: -0.23.w,
                  ),
                ),
                GestureDetector(
                  onTap: () => controller.selectDate(context), // 날짜 선택
                  child: Container(
                    width: 190.w,
                    height: 50.h,
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        side:
                            BorderSide(width: 1, color: AppTheme.primaryColor),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 12.w, vertical: 13.h),
                      child: Obx(
                        () => Text(
                          controller.getFormattedDate(), // 선택된 생년월일 표시
                          style: TextStyle(
                            color: controller.selectedDate.value != null
                                ? Colors.black
                                : Color(0xFF7C7C7C),
                            fontSize: 25.sp,
                            fontFamily: 'Jua',
                            fontWeight: FontWeight.w400,
                            height: 0.80.h,
                            letterSpacing: -0.23.w,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            Container(
              width: 164.w,
              height: 50.h,
              decoration: ShapeDecoration(
                color: AppTheme.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: GestureDetector(
                onTap: () {
                  controller.saveUserInfo();
                }, // 정보 저장 로직
                child: Center(
                  child: Text(
                    '등록하기',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25.sp,
                      fontFamily: 'Jua',
                      fontWeight: FontWeight.w400,
                      letterSpacing: -0.23.w,
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
