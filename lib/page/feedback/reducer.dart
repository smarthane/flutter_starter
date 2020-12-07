import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<FeedbackState> buildReducer() {
  return asReducer(
    <Object, Reducer<FeedbackState>>{
      FeedbackAction.action: _onAction,
    },
  );
}

FeedbackState _onAction(FeedbackState state, Action action) {
  final FeedbackState newState = state.clone();
  return newState;
}
