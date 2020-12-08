import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_starter/util/log_utils.dart';

import 'action.dart';
import 'state.dart';

/// @Author: smarthane
/// @GitHub: https://github.com/smarthane
/// @Description:
/// @Date: 2020/11/29

Reducer<BaseComponentsState> buildReducer() {
  return asReducer(
    <Object, Reducer<BaseComponentsState>>{
      BaseComponentsAction.action: _onAction,
    },
  );
}

BaseComponentsState _onAction(BaseComponentsState state, Action action) {
  LogUtils.v("BaseComponents ---------------------------> reducer");
  final BaseComponentsState newState = state.clone();
  return newState;
}
