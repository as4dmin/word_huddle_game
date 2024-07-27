import 'package:flutter/material.dart';
import 'package:wordgame/wordle.dart';

class WordleView extends StatelessWidget {
  final Wordle wordle;
  const WordleView({super.key, required this.wordle});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: wordle.existInTarget ? Colors.white60 : 
        wordle.notExistInTarget ? Colors.blueGrey.shade700 :
          null,
        border: Border.all(
          color: Colors.amber,
        )
      ),
      child: Text(wordle.letter, style: TextStyle(
        fontSize: 16,
        color: wordle.existInTarget ? Colors.black : 
          wordle.notExistInTarget ? Colors.white54 :
            Colors.white),
            ),
    );
  }
}