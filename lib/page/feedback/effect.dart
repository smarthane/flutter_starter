import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<FeedbackState> buildEffect() {
  return combineEffects(<Object, Effect<FeedbackState>>{
    FeedbackAction.action: _onAction,
  });
}

void _onAction(Action action, Context<FeedbackState> ctx) {
}
