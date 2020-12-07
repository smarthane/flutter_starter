import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<ImagePickersState> buildReducer() {
  return asReducer(
    <Object, Reducer<ImagePickersState>>{
      ImagePickersAction.action: _onAction,
    },
  );
}

ImagePickersState _onAction(ImagePickersState state, Action action) {
  final ImagePickersState newState = state.clone();
  return newState;
}
