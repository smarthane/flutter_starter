import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_starter/global_store/state.dart';

/// @Author: smarthane
/// @GitHub: https://github.com/smarthane
/// @Description:
/// @Date: 2020/11/29

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
  ..itemList = ["1.全局弹提示信息(应用内)", "2.全局弹提示信息(系统)"];
}
