import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

/// @Author: smarthane
/// @GitHub: https://github.com/smarthane
/// @Description:
/// @Date: 2020/11/29

Reducer<RegisterState> buildReducer() {
  return asReducer(
    <Object, Reducer<RegisterState>>{
      RegisterAction.action: _onAction,
    },
  );
}

RegisterState _onAction(RegisterState state, Action action) {
  final RegisterState newState = state.clone();
  return newState;
}
