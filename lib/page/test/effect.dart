import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_starter/broadcast/action.dart';
import 'action.dart';
import 'state.dart';

/// @Author: smarthane
/// @GitHub: https://github.com/smarthane
/// @Description:
/// @Date: 2020/11/29

Effect<TestState> buildEffect() {
  return combineEffects(<Object, Effect<TestState>>{
    TestAction.action: _onAction,
    //接受发送的广播消息
    BroadcastAction.toNotify: _receiveNotify,
  });
}

void _onAction(Action action, Context<TestState> ctx) {
  ///广播通信
  ctx.broadcast(BroadcastActionCreator.toNotify("发送广播"));
}

void _receiveNotify(Action action, Context<TestState> ctx) {}
