import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_starter/global_store/state.dart';

class BaseComponentsState implements Cloneable<BaseComponentsState>, GlobalBaseState {

  List<String> itemList;

  @override
  BaseComponentsState clone() {
    return BaseComponentsState()
    ..store = store
    ..itemList = itemList;
  }

  @override
  StoreModel store;
}

BaseComponentsState initState(Map<String, dynamic> args) {
  return BaseComponentsState()
  ..itemList = ["1.", "2."];
}
