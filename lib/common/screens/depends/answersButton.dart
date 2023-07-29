import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class AnswersButton extends StatelessWidget {
  String a;
  String text;
  void Function(String text, String a) onTap;

  AnswersButton(
      {required this.text,
      required this.a,
      required this.onTap,
      Key? key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return TextButton(
      onPressed: ()=>onTap(text, a),
      child: Text(
        text,
        style: TextStyle(
          fontSize: size.width * 0.048,
          fontWeight: FontWeight.w500,
          color: ColorApp.testText,
        ),
      ),
      style: TextButton.styleFrom(
        minimumSize: Size(size.width * 0.69, size.height * 0.077),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: const BorderSide(
            width: 2,
            color: ColorApp.SizedText1,
          ),
        ),
      ),
    );
  }
}
