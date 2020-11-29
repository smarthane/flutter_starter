import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

/// @Author: smarthane
/// @GitHub: https://github.com/smarthane
/// @Description:
/// @Date: 2020/11/29

Reducer<TestState> buildReducer() {
  return asReducer(
    <Object, Reducer<TestState>>{
      TestAction.action: _onAction,
    },
  );
}

TestState _onAction(TestState state, Action action) {
  final TestState newState = state.clone();
  return newState;
}
