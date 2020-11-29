import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

/// @Author: smarthane
/// @GitHub: https://github.com/smarthane
/// @Description:
/// @Date: 2020/11/29

Reducer<SplashState> buildReducer() {
  return asReducer(
    <Object, Reducer<SplashState>>{
      SplashAction.COUNTDOWN: _onAction,
    },
  );
}

SplashState _onAction(SplashState state, Action action) {
  final SplashState newState = state.clone();
  newState.count = action.payload;
  return newState;
}
