import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_starter/global_store/state.dart';

/// @Author: smarthane
/// @GitHub: https://github.com/smarthane
/// @Description:
/// @Date: 2020/11/29

class BotToastState implements Cloneable<BotToastState>, GlobalBaseState {
  BuildContext targetContext;

  bool flag;
  List<String> itemList;

  @override
  BotToastState clone() {
    return BotToastState()
      ..store = store
      ..itemList = itemList
      ..flag = flag
      ..targetContext = targetContext;
  }

  @override
  StoreModel store;
}

BotToastState initState(Map<String, dynamic> args) {
  return BotToastState()
    ..flag = true
    ..itemList = [
      "1.Show Text",
      "2.Show Custom Text",
      "3.Show Loading",
      "4.Show Custom Loading",
      "5.Show Simple Notification",
      "6.Show Notification",
      "7.Show Custom Notification",
      "8.Show Attached Widget",
      "9.Show Custom Widget",
    ];
}
