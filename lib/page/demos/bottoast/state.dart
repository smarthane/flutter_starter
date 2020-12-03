import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_starter/global_store/state.dart';

/// @Author: smarthane
/// @GitHub: https://github.com/smarthane
/// @Description:
/// @Date: 2020/11/29

class BotToastState implements Cloneable<BotToastState>, GlobalBaseState {
  List<String> itemList;

  @override
  BotToastState clone() {
    return BotToastState()
      ..store = store
      ..itemList = itemList;
  }

  @override
  StoreModel store;
}

BotToastState initState(Map<String, dynamic> args) {
  return BotToastState()
    ..itemList = [
      "1.Show Text",
      "2.Show Simple Notification",
      "3.Show Loading",
      "4.Show Custom Text"
    ];
}
