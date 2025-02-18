import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storymate/components/theme.dart';

class InfoController extends GetxController {
  // 사용자 정보 상태
  var userName = ''.obs;
  var selectedDate = Rxn<DateTime>();
  TextEditingController nameController =
      TextEditingController(); // 텍스트 필드 컨트롤러 추가

  /// 초기 정보 설정 (카카오에서 받은 값 적용)
  void setInitialInfo(String name, String birth) {
    userName.value = name;
    nameController.text = name;

    if (birth != "0000.00.00") {
      // 생년월일이 존재하면 DateTime으로 변환
      List<String> birthParts = birth.split('.');
      if (birthParts.length == 3) {
        int year = int.tryParse(birthParts[0]) ?? DateTime.now().year;
        int month = int.tryParse(birthParts[1]) ?? 1;
        int day = int.tryParse(birthParts[2]) ?? 1;
        selectedDate.value = DateTime(year, month, day);
      }
    }
  }

  /// 생년월일 선택 함수
  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate.value ?? DateTime.now(),
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
      selectedDate.value = picked; // 선택된 날짜 저장
    }
  }

  /// 선택된 날짜를 문자열 형식으로 반환
  String getFormattedDate() {
    if (selectedDate.value == null) {
      return '0000.00.00'; // 기본값
    }
    final date = selectedDate.value!;
    return '${date.year}.${date.month.toString().padLeft(2, '0')}.${date.day.toString().padLeft(2, '0')}';
  }
}
