import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final Function() answer;
  final String answerText;
  Answer(this.answer, this.answerText);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      child: ElevatedButton(
        
        style: ElevatedButton.styleFrom(
          
          primary:Color(0xB3F6C324),
          onPrimary: Colors.white,
          shadowColor: Colors.amber,
          minimumSize: Size(220, 60),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: Text(answerText,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            )),
        onPressed: answer,
        
      ),
    );
  }
}
