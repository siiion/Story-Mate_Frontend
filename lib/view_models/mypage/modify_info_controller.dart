import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ModifyInfoController extends GetxController {
  final box = GetStorage(); // GetStorage 인스턴스 생성

  // 사용자 정보 상태
  var username = ''.obs;
  var selectedDate = Rxn<DateTime>();

  TextEditingController nameController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    loadUserInfo();
  }

  /// 저장된 사용자 정보를 불러오기
  void loadUserInfo() {
    username.value = box.read("userName") ?? "사용자";
    nameController.text = username.value;

    String birthDate = box.read("userBirth") ?? "0000.00.00";
    if (birthDate != "0000.00.00") {
      List<String> parts = birthDate.split('.');
      if (parts.length == 3) {
        int year = int.tryParse(parts[0]) ?? DateTime.now().year;
        int month = int.tryParse(parts[1]) ?? 1;
        int day = int.tryParse(parts[2]) ?? 1;
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

  /// 변경된 사용자 정보를 저장
  void saveUserInfo() {
    box.write("userName", nameController.text);
    box.write("userBirth", getFormattedDate());
    username.value = nameController.text;

    Get.snackbar("정보 수정", "사용자 정보가 수정되었습니다.",
        snackPosition: SnackPosition.BOTTOM);
    Get.back(); // 수정 후 이전 페이지로 이동
  }
}
