import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<BaseComponentsState> buildEffect() {
  return combineEffects(<Object, Effect<BaseComponentsState>>{
    BaseComponentsAction.action: _onAction,
  });
}

void _onAction(Action action, Context<BaseComponentsState> ctx) {
}
