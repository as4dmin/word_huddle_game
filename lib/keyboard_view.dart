import 'package:flutter/material.dart';
import 'package:wordgame/huddleprovider.dart';

const  keysList = [
    ['Q','W','E','R','T','Y','U','I','O','P'],
    ['A','S','D','F','G','H','J','I','K','L'],
    ['Z','X','C','V','B','N','M']
  ];

class KeyboardView extends StatelessWidget {
  final List<String> excludedletters;
  final Function(String) onPressed;
  const KeyboardView({super.key, required this.excludedletters, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding:const  EdgeInsets.all(4),
        child: Column(
          children: [
            for(int i = 0; i < keysList.length; i++)
            Row(
              children: keysList[i].map((e) => VirtualKey(
                letter: e, 
                excluded: excludedletters.contains(e), 
                onPress: (value){
                  onPressed(value);
                }
                )).toList(),
            )
          ],
        ),
        ),
    );
  }
}

class VirtualKey extends StatelessWidget {

  final String letter;
  final bool excluded;
  final Function(String) onPress;

  const VirtualKey({super.key, 
  required this.letter,
  required this.excluded, 
  required this.onPress
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: excluded ? Colors.red : Colors.black,
          foregroundColor: Colors.white,
          padding: EdgeInsets.zero,
        ),
        onPressed: () {
          onPress(letter);
        },
        child: Text(letter),
      ),
    );
  }
}