import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<SqliteState> buildEffect() {
  return combineEffects(<Object, Effect<SqliteState>>{
    SqliteAction.action: _onAction,
  });
}

void _onAction(Action action, Context<SqliteState> ctx) {
}
