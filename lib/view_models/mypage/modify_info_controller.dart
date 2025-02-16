import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:storymate/components/theme.dart';

class ModifyInfoController extends GetxController {
  // 생년월일 상태
  var selectedDate = Rxn<DateTime>();

  // 카카오에서 받은 사용자 이름
  var username = RxString('');

  // 카카오 로그인 후 사용자 이름을 받아오는 함수
  Future<void> loginWithKakao() async {
    try {
      // 카카오톡으로 로그인 시도
      final result = await UserApi.instance.loginWithKakaoTalk();

      // 로그인 성공 시 사용자 정보 가져오기
      final user = await UserApi.instance.me();
      setUsername(
          user.kakaoAccount?.profile?.nickname ?? ''); // 카카오 로그인 후 사용자 이름 설정
    } catch (e) {
      print("카카오 로그인 실패: $e");
    }
  }

  // 생년월일 선택 함수
  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: AppTheme.primaryColor,
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      selectedDate.value = picked;
    }
  }

  // 선택된 날짜를 문자열 형식으로 반환
  String getFormattedDate() {
    if (selectedDate.value == null) {
      return '0000.00.00';
    }
    final date = selectedDate.value!;
    return '${date.year}.${date.month.toString().padLeft(2, '0')}.${date.day.toString().padLeft(2, '0')}';
  }

  void setUsername(String name) {
    username.value = name;
  }
}
