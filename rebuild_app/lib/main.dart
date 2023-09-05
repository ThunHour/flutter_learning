import 'package:flutter/material.dart';
import './quiz.dart';
import './result.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  final _questions = [
    {
      'questionText':
          'What is the best programming languages to learn in 2021?',
      'answer': [
        {'Text': 'Java', 'score': 10},
        {'Text': 'Swift', 'score': 5},
        {'Text': 'C#', 'score': 3},
        {'Text': 'Kotlin', 'score': 8},
      ]
    },
    {
      'questionText':
          'What is the best programming languages for website frontend to learn in 2021?',
      'answer': [
        {'Text': 'Python', 'score': 8},
        {'Text': 'TypeScript', 'score': 5},
        {'Text': 'JavaScript', 'score': 10},
        {'Text': 'PHP', 'score': 3},
      ]
    },
    {
      'questionText':
          'what is the best framework to become a full stack developer in 2021?',
      'answer': [
        {'Text': 'Node JS + Express.js', 'score': 3},
        {'Text': 'Spring Boot', 'score': 8},
        {'Text': 'React JS', 'score': 10},
        {'Text': 'Angular', 'score': 5},
      ],
    },
    {
      'questionText': 'What kind of song do you like?',
      'answer': [
        {'Text': 'NativeScript', 'score': 3},
        {'Text': 'Xamarin', 'score': 3},
        {'Text': 'Flutter', 'score': 8},
        {'Text': 'React Native', 'score': 10},
      ],
    },
    {
      'questionText': 'what is the best backend framework in 2021',
      'answer': [
        {'Text': 'Ruby – Ruby on Rails', 'score': 3},
        {'Text': 'JavaScript – Express.js, Spring', 'score': 8},
        {'Text': 'Python – Django, Flask', 'score': 10},
        {'Text': 'PHP – Laravel, CakePHP', 'score': 5},
      ],
    },
    {
      'questionText': 'waht is the most popular backend framework in 2021?',
      'answer': [
        {'Text': 'ExpressJS', 'score': 3},
        {'Text': 'Laravel', 'score': 10},
        {'Text': 'Flask', 'score': 5},
        {'Text': 'Django', 'score': 8},
      ],
    },
  ];
  void reSetQuiz() {
    setState(() {
      _questionIndex = 0;
      totalScore = 0;
    });
  }

  var _questionIndex = 0;
  var totalScore = 0;
  void _answerQuestion(int score) {
    setState(() {
      _questionIndex += 1;
      totalScore += score;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text('Quiz',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
            backgroundColor: Colors.amber,
          ),
          body: _questionIndex < _questions.length
              ? Quiz(
                  question: _questions,
                  answerQuestion: _answerQuestion,
                  questionIndex: _questionIndex)
              : Result(totalScore, reSetQuiz)),
    );
  }
}
