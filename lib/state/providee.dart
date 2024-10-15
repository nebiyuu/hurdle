// ignore_for_file: avoid_print

import 'dart:math';
import 'package:english_words/english_words.dart' as words;
import 'package:flutter/material.dart';
import 'package:hurdle/state/wordle.dart';

class Providee extends ChangeNotifier {
  final random = Random.secure();
  List<String> totalwords = [];
  List<String> rowinputs = [];
  List<String> excudedlist = [];
  List<Wordle> boardlist = [];
  bool correctornot = false;
  String targetword = '';
  int count = 0;
  int maxperrow = 5;

  bool get longenough => rowinputs.length == maxperrow;

  init() {
    totalwords = words.all.where((element) => element.length == 5).toList();
    generateboard();
    generateword();
  }

  bool get isvalid => totalwords.contains(rowinputs.join('').toLowerCase());

  bool get checklength => rowinputs.length == maxperrow;

  void checkanswer (){
    final input = rowinputs.join("");
    if(targetword ==input){
      correctornot = true;

    }
  }


  generateboard() {
    boardlist = List.generate(
      30,
      (index) => Wordle(letter: ''),
    );
  }

  generateword() {
    targetword = totalwords[random.nextInt(totalwords.length)].toUpperCase();
    print(targetword);
  }

  inputword(String letter) {
    if (count < maxperrow) {
      rowinputs.add(letter);
      boardlist[count] = Wordle(letter: letter);
      count++;
      print("rowinputs: $rowinputs");
      notifyListeners();
    } else {
      print("oberbound");
    }
  }

  deleteletter() {
    if (rowinputs.isNotEmpty) {
      rowinputs.removeAt(rowinputs.length - 1);
    }
    boardlist[count - 1] = Wordle(letter: " ");
    count--;
    print("rowinputs: $rowinputs");
    notifyListeners();
  }
}
