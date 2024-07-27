import 'dart:ffi';

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart' as words;
import 'package:wordgame/wordle.dart';

class huddleProvider extends ChangeNotifier{

  final random = Random.secure();
  List<String> totalWords = [];
  List<String> rowInputs = [];
  List<String> excludedletters = [];
  List<Wordle>  huddleBoard = []; 
  String targetWord = '';
  int count = 0;
  int index = 0;
  final lettersPerRow = 5;
  final totalAttempt = 6;
  int attempt = 0;
  bool win = false;

  bool get shouldCheckForAnswer => rowInputs.length == lettersPerRow;

  init(){
    totalWords = words.all.where((element) => element.length == 5).toList();
    generateBoard();
    generateRandom();
  }

  generateBoard() {
    huddleBoard = List.generate(30, (index) => Wordle(letter: ''));

  }

  generateRandom() {
    targetWord = totalWords[random.nextInt(totalWords.length)].toUpperCase();
    print(targetWord);

  }

  bool get isAValiWord => totalWords.contains(rowInputs.join('').toLowerCase());
  bool get noAttemptLeft => attempt == totalAttempt;


  inputLetters(String letter){
    if (count < lettersPerRow){
      count++;
      rowInputs.add(letter);
      huddleBoard[index] = Wordle(letter: letter);
      index++;
      print(rowInputs);
      notifyListeners();
    }
  }

  void deleteLetter(){
    if(rowInputs.isNotEmpty){
      rowInputs.removeAt(rowInputs.length - 1);
      print(rowInputs);
    }
    if(count > 0){
      huddleBoard[index - 1] = Wordle(letter: '');
      count--;
      index--;
    }
    notifyListeners();
  }

  void checkAnswer(){
    final input = rowInputs.join('');
    if(targetWord == input){
      win = true;
    }else{
      _markLetterOnBoard();
      if(attempt < totalAttempt){
        _goToNextRow();
      }
    }
  }

  void _markLetterOnBoard(){
    for(int i = 0; i < huddleBoard.length; i++){
      if(huddleBoard[i].letter.isNotEmpty && targetWord.contains(huddleBoard[i].letter)){
        huddleBoard[i].existInTarget = true;
      }else if(huddleBoard[i].letter.isNotEmpty && !targetWord.contains(huddleBoard[i].letter)){
        huddleBoard[i].notExistInTarget = true;
        excludedletters.add(huddleBoard[i].letter);
      }
    }
    notifyListeners();
  }

  void _goToNextRow(){
    count = 0;
    attempt++;
    rowInputs.clear();

  }

  reset(){
    count = 0;
    index = 0;
    rowInputs.clear();
    huddleBoard.clear();
    excludedletters.clear();
    targetWord = '';
    attempt = 0;
    win = false;
    generateBoard();
    generateRandom();
    notifyListeners();
  }

}