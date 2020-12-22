import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<SqliteState> buildReducer() {
  return asReducer(
    <Object, Reducer<SqliteState>>{
      SqliteAction.action: _onAction,
    },
  );
}

SqliteState _onAction(SqliteState state, Action action) {
  final SqliteState newState = state.clone();
  return newState;
}
