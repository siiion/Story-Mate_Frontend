import 'package:flutter/material.dart';
import 'package:storymate/components/theme.dart';

class CustomAlertDialog extends StatelessWidget {
  final String question;

  const CustomAlertDialog({
    super.key,
    required this.question,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppTheme.backgroundColor,
      title: Text(
        question,
        style: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontFamily: 'Jua',
          fontWeight: FontWeight.w400,
          height: 1.40,
          letterSpacing: -0.23,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text(
            '아니오',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 17,
              fontFamily: 'Jua',
              fontWeight: FontWeight.w400,
              height: 1.40,
              letterSpacing: -0.23,
            ),
          ),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text(
            '예',
            style: TextStyle(
              color: AppTheme.primaryColor,
              fontSize: 17,
              fontFamily: 'Jua',
              fontWeight: FontWeight.w400,
              height: 1.40,
              letterSpacing: -0.23,
            ),
          ),
        ),
      ],
    );
  }
}
