import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quizly/common/constants/colors.dart';
import 'package:quizly/common/screens/data/database.dart';
import 'package:quizly/common/screens/result/resultPage.dart';

import '../depends/answersButton.dart';

class QuizTest extends StatefulWidget {
  final List<int> list;
  final int time;

  const QuizTest({required this.list, required this.time, Key? key});

  @override
  State<QuizTest> createState() => _QuizTestState();
}

class _QuizTestState extends State<QuizTest> {
  Timer? timer1;
  ValueNotifier<int> correct=ValueNotifier<int>(0);

  ValueNotifier<int> timer = ValueNotifier<int>(0);

  ValueNotifier<int> index = ValueNotifier<int>(0);

  void onTap() {
    index.value++;
    timer.value = widget.time;
    if (index.value >= 10) {
      timer1?.cancel();
    }
  }

  void answersTap(String text, String a){
    if (text == a) {
      correct.value++;
    }
    if (index.value == 9) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ResultPage(
            correct: correct.value,
            time: widget.time,
          ),
        ),
      );
    }
    onTap();
  }

  void startTime() {
    timer1 = Timer.periodic(const Duration(seconds: 1), (_) {
      if (timer.value > 0) {
        timer.value--;
      }
      else if (timer.value == 0) {
        timer.value = widget.time;
        index.value++;
        if (index.value >= 10) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ResultPage(correct: correct.value,time: widget.time,),));
          timer1?.cancel();
        }
      }
    });
  }

  @override
  void initState() {
    timer.value = widget.time;
    if (widget.time == 0) {
      timer.value = 0;
    }
    else {
      startTime();
    }
    super.initState();
  }

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
                  height: size.height * 0.3,
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
                    top: size.height * 0.18,
                    left: (size.width - size.width * 0.73) / 2),
                child: SizedBox(
                  width: 0.73 * size.width,
                  height: 0.23 * size.height,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(0.04 * size.width),
                      boxShadow: const [
                        BoxShadow(
                          offset: Offset(0, 4),
                          blurRadius: 4,
                          color: ColorApp.shadow,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: size.height * 0.15,
                    left: (size.width - size.height * 0.09) / 2),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: size.height * 0.045,
                  child: ValueListenableBuilder(
                      valueListenable: timer,
                      builder: (context, value, child) {
                        return Stack(
                          children: [
                            Center(
                              child: SizedBox(
                                width: size.height * 0.067,
                                height: size.height * 0.067,
                                child: CircularProgressIndicator(
                                  value: widget.time == 0 ? 1 : timer.value /
                                      widget.time,
                                  color: ColorApp.SizedText1,
                                ),
                              ),
                            ),
                            Center(
                              child: Text(
                                "${timer.value}",
                                style: TextStyle(
                                  fontSize: size.width * 0.05,
                                  fontWeight: FontWeight.w700,
                                  color: ColorApp.SizedText1,
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                ),
              ),
              ValueListenableBuilder(
                  valueListenable: index,
                  builder: (context, value, child) {
                    return Padding(
                      padding: EdgeInsets.only(
                          top: size.height * 0.26, left: size.width * 0.375),
                      child: Text(
                        "Question ${("${index.value + 1}").padLeft(2, "0")}/10",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: size.width * 0.035,
                          color: ColorApp.SizedText1,
                        ),
                      ),
                    );
                  }),
              ValueListenableBuilder(
                  valueListenable: index,
                  builder: (context, value, child) {
                    return Padding(
                      padding: EdgeInsets.only(
                          top: size.height * 0.33, left: size.width * 0.42),
                      child: Text(
                        question[widget.list[index.value]]["name"].toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: size.width * 0.043,
                          color: ColorApp.testText,
                        ),
                      ),
                    );
                  }),
            ],
          ),
          ValueListenableBuilder(
              valueListenable: index,
              builder: (context, value, child) {
                return Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: size.height * 0.047),
                      child: AnswersButton(
                        text:
                        "${(question[widget.list[index
                            .value]]["javoblar"] as List<num>)[0]}",
                        a: question[widget.list[index.value]]["javob"]
                            .toString(),
                        onTap: answersTap,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: size.height * 0.034),
                      child: AnswersButton(
                        text:
                        "${(question[widget.list[index.value]]["javoblar"] as List<
                            num>)[1]}",
                        a: question[widget.list[index.value]]["javob"]
                            .toString(),
                        onTap: answersTap,
                      ),
                    ),
                    Padding(
                      padding:
                      EdgeInsets.symmetric(vertical: size.height * 0.034),
                      child: AnswersButton(
                        text:
                        "${(question[widget.list[index.value]]["javoblar"] as List<
                            num>)[2]}",
                        a: question[widget.list[index.value]]["javob"]
                            .toString(),
                        onTap: answersTap,
                      ),
                    ),
                    AnswersButton(
                      text:
                      "${(question[widget.list[index.value]]["javoblar"] as List<num>)[3]}",
                      a: question[widget.list[index.value]]["javob"].toString(),
                      onTap: answersTap,
                    ),
                  ],
                );
              }),
        ],
      ),
    );
  }
}
