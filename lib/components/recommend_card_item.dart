import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:storymate/components/custom_card.dart';
import 'package:storymate/components/theme.dart';
import 'package:storymate/views/read/book_intro_page.dart';

class RecommendCardItem extends StatelessWidget {
  final String title;
  final String tag;
  final String? character;
  final String? characterIntro;
  final bool isCharacter;

  const RecommendCardItem({
    super.key,
    required this.title,
    required this.tag,
    this.character = "캐릭터",
    this.characterIntro = "캐릭터 소개",
    required this.isCharacter,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 347.w,
      height: 181.h,
      decoration: ShapeDecoration(
        color: Color(0xFFF2F2F2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            CustomCard(
              title: title,
              tags: [],
              onTap: () {
                Get.to(BookIntroPage(), arguments: title);
              },
              coverImage: '',
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.h, left: 10.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 100.w),
                    child: Text(
                      isCharacter ? '주요 캐릭터' : '작품 설명',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontFamily: 'Jua',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  // 주요 캐릭터/작품 설명 소개
                  Container(
                    width: 191.w,
                    height: 77.h,
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: isCharacter
                          ? Row(
                              children: [
                                // 캐릭터 사진
                                Container(
                                  width: 60.w,
                                  height: 60.h,
                                  decoration: ShapeDecoration(
                                    color: Color(0xFFD9D9D9),
                                    shape: OvalBorder(
                                      side: BorderSide(width: 0.30.w),
                                    ),
                                  ),
                                ),
                                // 캐릭터명
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        character!,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18.sp,
                                          fontFamily: 'Jua',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      // 한 줄 소개
                                      Text(
                                        characterIntro!,
                                        style: TextStyle(
                                          color: Color(0xFF303030),
                                          fontSize: 11.sp,
                                          fontFamily: 'Jua',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          : Center(
                              child: Text(
                                '작품 설명 텍스트',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFF303030),
                                  fontSize: 11.sp,
                                  fontFamily: 'Jua',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                    ),
                  ),
                  // 대화하기/감상하기 버튼
                  Container(
                    width: 161.80.w,
                    height: 37.h,
                    decoration: ShapeDecoration(
                      color: AppTheme.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      shadows: [
                        BoxShadow(
                          color: Color(0x3F000000),
                          blurRadius: 3,
                          offset: Offset(0, 3),
                          spreadRadius: 0,
                        )
                      ],
                    ),
                    child: Center(
                      child: Text(
                        isCharacter
                            ? '$character와(과) 대화하러 가기'
                            : '$title 감상하러 가기',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13.sp,
                          fontFamily: 'Jua',
                          fontWeight: FontWeight.w400,
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
