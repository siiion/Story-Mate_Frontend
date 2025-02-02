import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:storymate/components/theme.dart';
import 'package:storymate/view_models/onboarding/terms_controller.dart';

class TermsPage extends StatefulWidget {
  const TermsPage({super.key});

  @override
  State<TermsPage> createState() => _TermsPageState();
}

class _TermsPageState extends State<TermsPage> {
  final TermsController controller = Get.put(TermsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: (MediaQuery.of(context).size.width - 331) / 2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                'assets/logo_terms.png',
                width: 331,
              ),
            ),
            SizedBox(
              height: 42,
            ),
            SvgPicture.asset('assets/terms_text.svg'),
            SizedBox(
              height: 42,
            ),
            // 전체 동의 체크박스
            Row(
              children: [
                Obx(() {
                  return GestureDetector(
                    onTap: controller.toggleAllAgreement,
                    child: Icon(
                      controller.allChecked.value
                          ? Icons.check_box
                          : Icons.check_box_outline_blank,
                      size: 30,
                    ),
                  );
                }),
                SizedBox(
                  width: 16,
                ),
                Text(
                  '모두 동의합니다.',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontFamily: 'Jua',
                    fontWeight: FontWeight.w400,
                    height: 1.40,
                    letterSpacing: -0.23,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 42,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 19.5),
              child: Column(
                children: [
                  // 서비스 이용 약관 동의 체크박스
                  Obx(
                    () => DetailTermsCheckBox(
                      terms: '[필수] 서비스 이용 약관 동의',
                      isChecked: controller.serviceAgreement.value,
                      onTap: () => controller.toServiceTermsDetail(),
                      onCheckToggle: controller.toggleServiceAgreement,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  // 개인정보 수집 및 이용 동의 체크박스
                  Obx(
                    () => DetailTermsCheckBox(
                      terms: '[필수] 개인정보 수집 및 이용 동의',
                      isChecked: controller.privacyAgreement.value,
                      onTap: () => controller.toPersonalInfoTermsDetail(),
                      onCheckToggle: controller.togglePrivacyAgreement,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  // 마케팅 정보 수신 동의 체크박스
                  Obx(
                    () => DetailTermsCheckBox(
                      terms: '[선택] 마케팅 정보 수신 동의',
                      isChecked: controller.marketingAgreement.value,
                      isDetailVisible: false,
                      onCheckToggle: controller.toggleMarketingAgreement,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 84,
            ),
            Center(
              child: Obx(
                () => GestureDetector(
                  onTap: controller.isAllRequiredChecked() ? () {} : null,
                  child: Container(
                    width: 300,
                    height: 55,
                    decoration: ShapeDecoration(
                      color: controller.isAllRequiredChecked()
                          ? AppTheme.primaryColor
                          : Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '확인',
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailTermsCheckBox extends StatelessWidget {
  final String terms;
  final bool isChecked;
  final bool? isDetailVisible;
  final Function()? onTap;
  final Function() onCheckToggle;

  const DetailTermsCheckBox({
    super.key,
    required this.terms,
    this.isDetailVisible = true,
    this.onTap,
    required this.onCheckToggle,
    required this.isChecked,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: onCheckToggle,
          child: Icon(
            isChecked ? Icons.check_box : Icons.check_box_outline_blank,
            size: 25,
          ),
        ),
        SizedBox(
          width: 5,
        ),
        Text(
          terms,
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontFamily: 'Jua',
            fontWeight: FontWeight.w400,
            height: 1.94,
            letterSpacing: -0.23,
          ),
        ),
        SizedBox(
          width: 5,
        ),
        isDetailVisible!
            ? // 세부 내용 보기 버튼
            GestureDetector(
                onTap: onTap,
                child: Icon(
                  Icons.arrow_forward_ios,
                  size: 15,
                ),
              )
            : SizedBox(),
      ],
    );
  }
}
