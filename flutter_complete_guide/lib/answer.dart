import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final Function() selectHandler;
  final String answerText;
  //final is the type using for store value can not change and it is initialized when accessd
  // but const is the type for store value can not change and can only store the exact value and can not store the result of any method.

  // data type of the selectHandler can be Function() or VoidCallback
  // ignore: use_key_in_widget_constructors
  const Answer(this.selectHandler, this.answerText);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      // child: ElevatedButton(
      //   //ElevatedButton use for replace Raisedbutton with the new method.
      //   style: ElevatedButton.styleFrom(
      //     primary: Colors.amber,
      //     onPrimary: Colors.white
      //   ),
      //   child: Text(answerText),
      //   onPressed: selectHandler,
      // ),

      // child: OutlinedButton(
      //   style: OutlinedButton.styleFrom(
      //     primary: Colors.amber,
      //     side: const BorderSide(
      //       color: Colors.black,
      //     ),
      //   ),
      //   child: Text(answerText),
      //   onPressed: selectHandler,
      // ),

      child: TextButton(
        style: TextButton.styleFrom(primary: Colors.black),
        child: Text(answerText),
        onPressed: selectHandler,
      ),
    );
  }
}
