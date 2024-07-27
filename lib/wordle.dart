import 'main.dart';
import 'package:flutter/material.dart';

class Wordle{

  String letter;
  bool existInTarget;
  bool notExistInTarget;

  Wordle({
    required this.letter,
    this.existInTarget = false, 
    this.notExistInTarget = false,
    });

}