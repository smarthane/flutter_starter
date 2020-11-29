import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

/// @Author: smarthane
/// @GitHub: https://github.com/smarthane
/// @Description:
/// @Date: 2020/11/29

Reducer<DemosState> buildReducer() {
  return asReducer(
    <Object, Reducer<DemosState>>{
      DemosAction.action: _onAction,
    },
  );
}

DemosState _onAction(DemosState state, Action action) {
  final DemosState newState = state.clone();
  return newState;
}
