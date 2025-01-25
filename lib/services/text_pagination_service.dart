// 텍스트를 페이지로 나누기 (화면에 표시 가능한 분량으로 나누기)

import 'package:flutter/material.dart';

List<String> paginateText(
    String text, double screenWidth, double screenHeight, TextStyle textStyle) {
  final List<String> pages = [];
  final textPainter = TextPainter(
    textDirection: TextDirection.ltr,
    textAlign: TextAlign.start,
  );

  final words = text.split(' ');
  String currentPage = '';

  for (String word in words) {
    final testText = currentPage.isEmpty ? word : '$currentPage $word';
    textPainter.text = TextSpan(text: testText, style: textStyle);
    textPainter.layout(maxWidth: screenWidth);

    if (textPainter.size.height > screenHeight) {
      pages.add(currentPage);
      currentPage = word; // 현재 단어로 새 페이지 시작
    } else {
      currentPage = testText;
    }
  }

  if (currentPage.isNotEmpty) {
    pages.add(currentPage); // 마지막 페이지 추가
  }

  return pages;
}
