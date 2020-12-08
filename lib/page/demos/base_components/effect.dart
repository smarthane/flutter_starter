import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_starter/broadcast/action.dart';
import 'package:flutter_starter/util/log_utils.dart';
import 'action.dart';
import 'state.dart';

/// @Author: smarthane
/// @GitHub: https://github.com/smarthane
/// @Description:
/// @Date: 2020/11/29

Effect<BaseComponentsState> buildEffect() {
  return combineEffects(<Object, Effect<BaseComponentsState>>{
    BaseComponentsAction.action: _onAction,
  });
}

void _onAction(Action action, Context<BaseComponentsState> ctx) {
  var index = action.payload;
  LogUtils.v("BaseComponents ---------------------------> effect $index");
  switch (index) {
    case 0:
      /// 应用内： 传输payload 根据 业务定
      ctx.broadcast(BroadcastActionCreator.notifyAppNotifications("Hello Flutter Starter !"));
      break;
    case 1:
      /// 系统： 传输payload 根据 业务定
      ctx.broadcast(BroadcastActionCreator.notifySysNotifications("Hello Flutter Starter !"));
      break;
    default:
      break;
  }
}
