import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_starter/global_store/state.dart';

class FeedbackState implements Cloneable<FeedbackState> , GlobalBaseState {
  @override
  FeedbackState clone() {
    return FeedbackState()..store = store;
  }

  @override
  StoreModel store;
}

FeedbackState initState(Map<String, dynamic> args) {
  return FeedbackState();
}
