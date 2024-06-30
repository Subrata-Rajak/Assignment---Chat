import 'dart:async';
import 'package:flutter/material.dart';

/*
* This is a basic debouncer function which can be called 
* if we want some action to perform with a delay
*/

class Debouncer {
  final int milliseconds; //? time duration that is needed to perform the action
  VoidCallback?
      action; //? callback function in the which we perform the task/action
  Timer?
      _timer; //? The timer which will take a note of the duration and notify once the delay is met

  Debouncer(
      {required this.milliseconds}); //? basic constructor of the class with one param

  void run(VoidCallback action) {
    if (_timer != null) {
      _timer!
          .cancel(); //? once the delay is met the timer will be cancelled and will be initialized again once it is fired
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
