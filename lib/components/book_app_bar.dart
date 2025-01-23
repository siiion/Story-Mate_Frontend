import 'package:flutter/material.dart';
import 'package:storymate/components/theme.dart';

class BookAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title; // 작품 제목
  final Function() onLeadingTap; // 뒤로가기 클릭 시

  const BookAppBar({
    super.key,
    required this.title,
    required this.onLeadingTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppTheme.backgroundColor,
      leading: GestureDetector(
        onTap: onLeadingTap,
        child: Icon(Icons.arrow_back_ios_new),
      ),
      centerTitle: false,
      title: Text(
        title,
        style: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontFamily: 'Nanum',
          fontWeight: FontWeight.w600,
          height: 1,
          letterSpacing: -0.23,
        ),
      ),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(1.0),
        child: Container(
          height: 1.0,
          color: Color(0xffa2a2a2),
        ),
      ),
    );
  }

  @override
  Size get preferredSize =>
      const Size.fromHeight(56.0 + 1.0); // AppBar 높이 + Border
}
