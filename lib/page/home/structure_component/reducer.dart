import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

/// @Author: smarthane
/// @GitHub: https://github.com/smarthane
/// @Description:
/// @Date: 2020/11/29

Reducer<TabStructureState> buildReducer() {
  return asReducer(
    <Object, Reducer<TabStructureState>>{
      TabStructureAction.action: _onAction,
    },
  );
}

TabStructureState _onAction(TabStructureState state, Action action) {
  final TabStructureState newState = state.clone();
  return newState;
}
