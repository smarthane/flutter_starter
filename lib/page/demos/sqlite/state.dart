import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_starter/global_store/state.dart';

class SqliteState implements Cloneable<SqliteState>, GlobalBaseState {

  List<String> itemList;

  @override
  SqliteState clone() {
    return SqliteState()
      ..store = store
      ..itemList = itemList;
  }

  @override
  StoreModel store;
}

SqliteState initState(Map<String, dynamic> args) {
  return SqliteState()
    ..itemList = [
      "1.",
      "2.",
      "3.",
    ];
}
