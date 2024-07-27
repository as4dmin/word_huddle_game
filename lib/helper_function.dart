
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


void showMsg(BuildContext context, String msg) =>
ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(content: Text(msg)));


void showResults({
  required BuildContext context,
  required String title,
  required String body,
  required VoidCallback onPlayAgain,
  required VoidCallback onCancel

}){
  showDialog(context: context, builder: (context) => AlertDialog(
    title: Text(title),
    content: Text(body),
    actions: [
      TextButton(
        onPressed: onCancel, 
        child: const Text("QUIT"),
        ),
        TextButton(
        onPressed: onPlayAgain, 
        child: const Text("Play Again"),
        ),
    ],
  ));

}