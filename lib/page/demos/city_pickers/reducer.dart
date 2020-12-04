import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<CityPickersState> buildReducer() {
  return asReducer(
    <Object, Reducer<CityPickersState>>{
      CityPickersAction.action: _onAction,
    },
  );
}

CityPickersState _onAction(CityPickersState state, Action action) {
  final CityPickersState newState = state.clone();
  return newState;
}
