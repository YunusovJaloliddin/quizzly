import 'dart:math';

import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../depends/answersButton.dart';
import '../homescreen/homePage.dart';
import '../quizTest/quizTest.dart';

class ResultPage extends StatelessWidget {
  final int correct;
  final int time;

  const ResultPage(
      {required this.correct,
      required this.time,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        height: size.height * 0.065,
        color: ColorApp.SizedText1,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Center(
          child: Text(
            "QUIZZLY",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: size.height * 0.02,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Stack(
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  color: ColorApp.SizedText1,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(size.height * 0.06),
                    bottomRight: Radius.circular(size.height * 0.06),
                  ),
                ),
                child: SizedBox(
                  height: size.height * 0.45,
                  width: double.infinity,
                ),
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: size.height * 0.05,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: size.height * 0.39,
                    left: (size.width - size.width * 0.82) / 2),
                child: SizedBox(
                  width: 0.82 * size.width,
                  height: 0.18 * size.height,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(0.06 * size.width),
                      boxShadow: const [
                        BoxShadow(
                          offset: Offset(0, 4),
                          blurRadius: 4,
                          color: Color(0x80000000),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                radius: 10,
                                backgroundColor: ColorApp.correct,
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "$correct",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: size.width * 0.048,
                                    color: ColorApp.correct,
                                  ),
                                ),
                                Text(
                                  "Correct",
                                  style: TextStyle(
                                    fontSize: size.width * 0.038,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                  radius: 10,
                                  backgroundColor: ColorApp.incorrect),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "${10-correct}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: size.width * 0.048,
                                    color: ColorApp.incorrect,
                                  ),
                                ),
                                Text(
                                  "Incorrect",
                                  style: TextStyle(
                                    fontSize: size.width * 0.038,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: size.height * 0.11, left: size.width * 0.58 / 2),
                child: CircleAvatar(
                  radius: size.width * 0.21,
                  backgroundColor: const Color(0x40FFFFFF),
                  child: CircleAvatar(
                    radius: size.width * 0.17,
                    backgroundColor: const Color(0x4DFFFFFF),
                    child: CircleAvatar(
                      radius: size.width * 0.14,
                      backgroundColor: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Your Score",
                            style: TextStyle(
                              fontSize: size.width * 0.048,
                              fontWeight: FontWeight.w500,
                              color: ColorApp.SizedText1,
                            ),
                          ),
                          Text(
                            "${correct * 10}",
                            style: TextStyle(
                              fontSize: size.width * 0.077,
                              fontWeight: FontWeight.w700,
                              color: ColorApp.SizedText1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(
                top: size.height * 0.11, bottom: size.height * 0.034),
            child: AnswersButton(
              text: "Play again",
              a: "javob",
              onTap: (text, a) {
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
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuizTest(
                        list: list,
                        time: time,
                      ),
                    ));
                print(list);
              },
            ),
          ),
          AnswersButton(
            text: "Home",
            a: "javob",
            onTap: (text,a) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                ));
            },
          ),
        ],
      ),
    );
  }
}
