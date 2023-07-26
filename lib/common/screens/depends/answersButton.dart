import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../result/resultPage.dart';

int correct = 0;
int incrorrect = 0;
int pressed=0;

class AnswersButton extends StatelessWidget {
  String a;
  String text;
  int index;
  int time;
  void Function() onTap;

  AnswersButton(
      {required this.text,
      required this.a,
      required this.onTap,
      required this.index,
      required this.time,
      Key? key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return TextButton(
      onPressed: () {
        if (text == a) {
          correct++;
          if (index == 9) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ResultPage(
                  correct: correct,
                  incorrect: incrorrect,
                  time: time,
                ),
              ),
            );
          }
        } else {
          incrorrect++;
          if (index == 9) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ResultPage(
                  correct: correct,
                  incorrect: incrorrect,
                  time: time,
                ),
              ),
            );
          }
        }
        onTap();
        pressed++;
        if(pressed==11){
          pressed=0;
          correct = 0;
          incrorrect = 0;
        }
      },
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
