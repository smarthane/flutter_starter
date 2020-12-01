import 'dart:math';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/animation.dart';
import 'package:flutter_starter/global_store/state.dart';
import 'package:flutter_starter/util/timer_utils.dart';

/// @Author: smarthane
/// @GitHub: https://github.com/smarthane
/// @Description:
/// @Date: 2020/11/29

class SplashState implements Cloneable<SplashState>, GlobalBaseState {
  static const int LIMIT_TIME_COUNT = 5;

  int count = LIMIT_TIME_COUNT;

  TimerUtils timerUtils;
  AnimationController logoController;
  Animation<double> animation;

  bool randomAnimFile = Random().nextBool();

  @override
  SplashState clone() {
    return SplashState()
      ..timerUtils = timerUtils
      ..count = count
      ..store = store
      ..logoController = logoController
      ..animation = animation
    ..randomAnimFile = randomAnimFile;
  }

  @override
  StoreModel store;
}

SplashState initState(Map<String, dynamic> args) {
  return SplashState();
}
