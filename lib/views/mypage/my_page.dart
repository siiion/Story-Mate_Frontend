import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:storymate/components/custom_alert_dialog.dart';
import 'package:storymate/components/custom_bottom_bar.dart';
import 'package:storymate/components/custom_card.dart';
import 'package:storymate/components/theme.dart';
import 'package:storymate/view_models/mypage/my_controller.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  final MyController controller = Get.put(MyController());

  // 샘플 데이터
  final List<Map<String, String>> items = [
    {"title": "작품 제목 1", "tags": "#태그1 #태그2"},
    {"title": "작품 제목 2", "tags": "#태그3 #태그4"},
    {"title": "작품 제목 3", "tags": "#태그5 #태그6"},
    {"title": "작품 제목 4", "tags": "#태그7 #태그8"},
  ];

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
          child: Icon(Icons.arrow_back_ios_new),
        ),
        centerTitle: true,
        title: Text(
          '마이페이지',
          style: TextStyle(
            color: Colors.black,
            fontSize: 25.sp,
            fontFamily: 'Jua',
            fontWeight: FontWeight.w400,
            height: 0.80.h,
            letterSpacing: -0.23.w,
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomBar(currentIndex: 2),
      body: Column(
        children: [
          Container(
            height: 0.5.h,
            color: Color(0xffa2a2a2),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 25.w),
              child: ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 25.w, top: 30.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            // 유저 이름
                            Text(
                              '사용자님,',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 25.sp,
                                fontFamily: 'Jua',
                                fontWeight: FontWeight.w400,
                                height: 0.80.h,
                                letterSpacing: -0.23.w,
                              ),
                            ),
                            SizedBox(
                              height: 8.h,
                            ),
                            // 생년월일
                            Text(
                              'xxxx.xx.xx',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.sp,
                                fontFamily: 'Jua',
                                fontWeight: FontWeight.w400,
                                height: 1.h,
                                letterSpacing: -0.23.w,
                              ),
                            ),
                          ],
                        ),
                        // 내 정보 수정 버튼
                        GestureDetector(
                          onTap: () {
                            Get.toNamed('/my_page/info');
                          },
                          child: Container(
                            width: 150.w,
                            height: 50.h,
                            decoration: ShapeDecoration(
                              color: Color(0xFF9B9ECF),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                '내 정보 수정',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.sp,
                                  fontFamily: 'Jua',
                                  fontWeight: FontWeight.w400,
                                  height: 1.h,
                                  letterSpacing: -0.23.w,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 25.w),
                    child: Container(
                      height: 1.h,
                      color: Color(0xffd9d9d9),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  CategoryText(text: '감상 중인 작품'),
                  SizedBox(
                    height: 5.h,
                  ),
                  // 감상 중인 작품 리스트
                  SizedBox(
                    height: 180.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final item = items[index];
                        return Padding(
                          padding: EdgeInsets.only(
                              top: 10.h, bottom: 10.h, right: 10.w),
                          child: CustomCard(
                            title: item["title"] ?? "",
                            tags: [],
                            onTap: () {
                              controller.toIntroPage(item["title"]!);
                            },
                            coverImage: '',
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  CategoryText(text: '감상한 작품'),
                  SizedBox(
                    height: 5.h,
                  ),
                  // 감상한 작품 리스트
                  SizedBox(
                    height: 180.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final item = items[index];
                        return Padding(
                          padding: EdgeInsets.only(
                              top: 10.h, bottom: 10.h, right: 10.w),
                          child: CustomCard(
                            title: item["title"] ?? "",
                            tags: [],
                            onTap: () {
                              controller.toIntroPage(item["title"]!);
                            },
                            coverImage: '',
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.chat_bubble_outline,
                        color: AppTheme.primaryColor,
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      CategoryText(text: '메세지 충전'),
                    ],
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 25.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // 남은 메세지 개수
                        Container(
                          width: 150.w,
                          height: 35.h,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  width: 1.w, color: AppTheme.primaryColor),
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              '남은 메세지: 00개',
                              style: TextStyle(
                                color: Color(0xFF9B9ECF),
                                fontSize: 16.sp,
                                fontFamily: 'Jua',
                                fontWeight: FontWeight.w400,
                                height: 1.25.h,
                                letterSpacing: -0.23.w,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        // 충전하러 가기 버튼
                        GestureDetector(
                          onTap: () {}, // 충전 화면으로
                          child: Container(
                            width: 150.w,
                            height: 35.h,
                            decoration: ShapeDecoration(
                              color: AppTheme.primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                '충전하러 가기',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                  fontFamily: 'Jua',
                                  fontWeight: FontWeight.w400,
                                  height: 1.25.h,
                                  letterSpacing: -0.23.w,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 25.w, bottom: 30.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // 로그아웃 버튼
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            '로그아웃',
                            style: TextStyle(
                              color: Color(0xFF7C7C7C),
                              fontSize: 14.sp,
                              fontFamily: 'Jua',
                              fontWeight: FontWeight.w400,
                              decoration: TextDecoration.underline,
                              height: 1.43.h,
                              letterSpacing: -0.23.w,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 50.h,
                        ),
                        Container(
                          width: 1.w,
                          height: 20.h,
                          color: Color(0xffd9d9d9),
                        ),
                        SizedBox(
                          width: 50.h,
                        ),
                        // 회원 탈퇴 버튼
                        GestureDetector(
                          onTap: () async {
                            final result = await showDialog<bool>(
                              context: context,
                              builder: (BuildContext context) {
                                return CustomAlertDialog(
                                    question: '정말 StoryMate에서\n탈퇴하시겠어요? 😢');
                              },
                            );
                            if (result == true) {
                              // '예' 클릭 시
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    backgroundColor: AppTheme.backgroundColor,
                                    content: Padding(
                                      padding: const EdgeInsets.all(20),
                                      child: Text(
                                        '탈퇴 처리되었습니다.\n다음에 또 만나요 👋',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 25.sp,
                                          fontFamily: 'Jua',
                                          fontWeight: FontWeight.w400,
                                          height: 1.40.h,
                                          letterSpacing: -0.23.w,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            } else {
                              // '아니오' 클릭 시
                              // 아무 동작도 하지 않고 다이얼로그를 닫음
                            }
                          },
                          child: Text(
                            '회원 탈퇴',
                            style: TextStyle(
                              color: Color(0xFF7C7C7C),
                              fontSize: 14.sp,
                              fontFamily: 'Jua',
                              fontWeight: FontWeight.w400,
                              decoration: TextDecoration.underline,
                              height: 1.43.h,
                              letterSpacing: -0.23.w,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryText extends StatelessWidget {
  final String text;

  const CategoryText({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: AppTheme.primaryColor,
        fontSize: 20,
        fontFamily: 'Jua',
        fontWeight: FontWeight.w400,
        height: 1,
        letterSpacing: -0.23,
      ),
    );
  }
}
