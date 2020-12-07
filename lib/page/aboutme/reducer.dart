import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<AboutMeState> buildReducer() {
  return asReducer(
    <Object, Reducer<AboutMeState>>{
      AboutMeAction.action: _onAction,
    },
  );
}

AboutMeState _onAction(AboutMeState state, Action action) {
  final AboutMeState newState = state.clone();
  return newState;
}
