import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

/// @Author: smarthane
/// @GitHub: https://github.com/smarthane
/// @Description:
/// @Date: 2020/11/29

Reducer<BotToastState> buildReducer() {
  return asReducer(
    <Object, Reducer<BotToastState>>{
      BotToastAction.action: _onAction,
    },
  );
}

BotToastState _onAction(BotToastState state, Action action) {
  final BotToastState newState = state.clone();
  return newState;
}
