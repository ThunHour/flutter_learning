import 'package:flutter/material.dart';
import './quiz.dart';
import './result.dart';

// void main() {
//   runApp(MyApp());
// }
void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  final _questions = [
    {
      'questionText': 'What is your favorite color?',
      'answer': [
        {'Text': 'blue', 'score': 10},
        {'Text': 'red', 'score': 8},
        {'Text': 'green', 'score': 5},
        {'Text': 'yellow', 'score': 3},
      ]
    },
    {
      'questionText': 'What is your favorite Youtuber?',
      'answer': [
        {'Text': 'BunLeng', 'score': 10},
        {'Text': 'HengViSal', 'score': 8},
        {'Text': 'Reven', 'score': 5},
        {'Text': 'Heng', 'score': 3},
      ]
    },
    {
      'questionText': 'What kind of song do you like?',
      'answer': [
        {'Text': 'Classic', 'score': 10},
        {'Text': 'Rock', 'score': 8},
        {'Text': 'Pop', 'score': 5},
        {'Text': 'Hip Hop', 'score': 3},
      ],
    },
  ];
  var _questionIndex = 0;
  var _totalScore = 0;
  void resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
    });
  }

  void _answerQuestion(int score) {
    _totalScore += score;
    setState(() {
      _questionIndex = _questionIndex + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text('My Frist App'),
          ),
          body: _questionIndex < _questions.length
              ? Quiz(
                  questions: _questions,
                  answerQuestion: _answerQuestion,
                  questionIndex: _questionIndex)
              : Result(_totalScore, resetQuiz)),
    );
  }
}
