import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final Function() resetHandler;
  final int rescultScore;
  String get resultPhrase {
    var resultText = '';
    if (rescultScore <= 8) {
      resultText = 'You are awesome';
    } else if (rescultScore <= 12) {
      resultText = 'Pretty likeable';
    } else if (rescultScore > 16) {
      resultText = 'You are ... Strange?';
    } else {
      resultText = 'You are so bad!';
    }
    return resultText;
  }

  Result(this.rescultScore, this.resetHandler);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            resultPhrase,
            style: const TextStyle(
                color: Colors.black, fontSize: 38, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          TextButton(
            style:TextButton.styleFrom(primary: Colors.red,side:BorderSide(color:Colors.redAccent,)),
            child: const Text("Restart Quiz!"),
            onPressed: resetHandler,
          )
        ],
      ),
    );
  }
}
