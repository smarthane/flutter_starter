import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<AboutMeState> buildEffect() {
  return combineEffects(<Object, Effect<AboutMeState>>{
    AboutMeAction.action: _onAction,
  });
}

void _onAction(Action action, Context<AboutMeState> ctx) {
}
