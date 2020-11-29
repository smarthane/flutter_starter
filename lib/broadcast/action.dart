import 'package:fish_redux/fish_redux.dart';

/// @Author: smarthane
/// @GitHub: https://github.com/smarthane
/// @Description:
/// @Date: 2020/11/29

enum BroadcastAction { toNotify }

class BroadcastActionCreator {
  ///广播通知
  static Action toNotify(String msg) {
    return Action(BroadcastAction.toNotify, payload: msg);
  }
}
