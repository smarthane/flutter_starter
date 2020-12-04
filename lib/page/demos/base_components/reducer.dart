import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<BaseComponentsState> buildReducer() {
  return asReducer(
    <Object, Reducer<BaseComponentsState>>{
      BaseComponentsAction.action: _onAction,
    },
  );
}

BaseComponentsState _onAction(BaseComponentsState state, Action action) {
  final BaseComponentsState newState = state.clone();
  return newState;
}
