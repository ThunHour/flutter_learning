import 'package:flutter/material.dart';
import "./answer.dart";
import "./question.dart";

class Quiz extends StatelessWidget {
  final List<Map<String, Object>> question;
  final Function answerQuestion;
  final int questionIndex;
  Quiz(
      {required this.question,
      required this.answerQuestion,
      required this.questionIndex});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Question(question[questionIndex]['questionText'] as String),
      ...(question[questionIndex]['answer'] as List<Map<String, Object>>)
          .map((elementnswer) {
        return Answer(() => answerQuestion(elementnswer['score']),
            elementnswer['Text'] as String);
      }).toList()
    ]);
  }
}
