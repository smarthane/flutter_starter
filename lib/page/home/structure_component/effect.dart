import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<TabStructureState> buildEffect() {
  return combineEffects(<Object, Effect<TabStructureState>>{
    TabStructureAction.action: _onAction,
  });
}

void _onAction(Action action, Context<TabStructureState> ctx) {
}
