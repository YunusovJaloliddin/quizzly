import 'dart:math';

import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../quizTest/quizTest.dart';

class LevelButton extends StatelessWidget {
  final String text;
  final int time;

  const LevelButton({required this.text, required this.time,Key? key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return FilledButton(
      style: FilledButton.styleFrom(
        backgroundColor: ColorApp.backgroundColor,
        minimumSize: Size(
          size.width * 0.69,
          size.height * 0.077,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        side: const BorderSide(
          width: 3,
          color: Colors.white,
        ),
      ),
      onPressed: () {
        int rand() {
          return Random().nextInt(50);
        }

        List<int> list = [];
        for (int i = 0; i < 50; i++) {
          int random = rand();
          while (list.contains(random)) {
            random = rand();
          }
          list.add(random);
        }
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => QuizTest(
                list: list,
                time: time,
              ),
            ));
        print(list);
      },
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 20 * size.height / 731,
          color: Colors.white,
        ),
      ),
    );
  }
}
