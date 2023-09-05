import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int toTal;
  final Function() reSet;
  String get resultPhrse {
    return 'Congratculations You Did it \n Your Score is ' + toTal.toString();
  }

  Result(this.toTal, this.reSet);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 100.0),
      width: double.infinity,
      child: Column(children: [
        Text(resultPhrse,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center),
        Container(
          margin: EdgeInsets.only(top: 30),
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              minimumSize: Size(200, 50),
              side: const BorderSide(width: 3, color: Color(0xFFCC5500)),
              primary: Color(0xFFCC5500),
            ),
            child: const Text('ReStart Quiz',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                )),
            onPressed: reSet,
          ),
        ),
      ]),
    );
  }
}
