import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_starter/global_store/state.dart';

/// @Author: smarthane
/// @GitHub: https://github.com/smarthane
/// @Description:
/// @Date: 2020/11/29

class TestState implements Cloneable<TestState>, GlobalBaseState {
  @override
  TestState clone() {
    return TestState()..store = store;
  }

  @override
  StoreModel store;
}

TestState initState(Map<String, dynamic> args) {
  return TestState();
}
