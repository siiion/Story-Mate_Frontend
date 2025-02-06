import 'package:flutter/material.dart';
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
            fontSize: 25,
            fontFamily: 'Jua',
            fontWeight: FontWeight.w400,
            height: 0.80,
            letterSpacing: -0.23,
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomBar(currentIndex: 2),
      body: Column(
        children: [
          Container(
            height: 0.5,
            color: Color(0xffa2a2a2),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 25),
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 25, top: 30),
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
                                fontSize: 25,
                                fontFamily: 'Jua',
                                fontWeight: FontWeight.w400,
                                height: 0.80,
                                letterSpacing: -0.23,
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            // 생년월일
                            Text(
                              'xxxx.xx.xx',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontFamily: 'Jua',
                                fontWeight: FontWeight.w400,
                                height: 1,
                                letterSpacing: -0.23,
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
                            width: 150,
                            height: 50,
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
                                  fontSize: 20,
                                  fontFamily: 'Jua',
                                  fontWeight: FontWeight.w400,
                                  height: 1,
                                  letterSpacing: -0.23,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 25),
                    child: Container(
                      height: 1,
                      color: Color(0xffd9d9d9),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CategoryText(text: '감상 중인 작품'),
                  SizedBox(
                    height: 5,
                  ),
                  // 감상 중인 작품 리스트
                  SizedBox(
                    height: 180,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final item = items[index];
                        return Padding(
                          padding: const EdgeInsets.only(
                              top: 10, bottom: 10, right: 10),
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
                    height: 20,
                  ),
                  CategoryText(text: '감상한 작품'),
                  SizedBox(
                    height: 5,
                  ),
                  // 감상한 작품 리스트
                  SizedBox(
                    height: 180,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final item = items[index];
                        return Padding(
                          padding: const EdgeInsets.only(
                              top: 10, bottom: 10, right: 10),
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
                    height: 20,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.chat_bubble_outline,
                        color: AppTheme.primaryColor,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      CategoryText(text: '메세지 충전'),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // 남은 메세지 개수
                        Container(
                          width: 150,
                          height: 35,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  width: 1, color: AppTheme.primaryColor),
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              '남은 메세지: 00개',
                              style: TextStyle(
                                color: Color(0xFF9B9ECF),
                                fontSize: 16,
                                fontFamily: 'Jua',
                                fontWeight: FontWeight.w400,
                                height: 1.25,
                                letterSpacing: -0.23,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        // 충전하러 가기 버튼
                        GestureDetector(
                          onTap: () {}, // 충전 화면으로
                          child: Container(
                            width: 150,
                            height: 35,
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
                                  fontSize: 16,
                                  fontFamily: 'Jua',
                                  fontWeight: FontWeight.w400,
                                  height: 1.25,
                                  letterSpacing: -0.23,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 25, bottom: 30),
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
                              fontSize: 14,
                              fontFamily: 'Jua',
                              fontWeight: FontWeight.w400,
                              decoration: TextDecoration.underline,
                              height: 1.43,
                              letterSpacing: -0.23,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 50,
                        ),
                        Container(
                          width: 1,
                          height: 20,
                          color: Color(0xffd9d9d9),
                        ),
                        SizedBox(
                          width: 50,
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
                                          fontSize: 25,
                                          fontFamily: 'Jua',
                                          fontWeight: FontWeight.w400,
                                          height: 1.40,
                                          letterSpacing: -0.23,
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
                              fontSize: 14,
                              fontFamily: 'Jua',
                              fontWeight: FontWeight.w400,
                              decoration: TextDecoration.underline,
                              height: 1.43,
                              letterSpacing: -0.23,
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
