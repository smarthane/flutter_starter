import 'package:fish_redux/fish_redux.dart';

/// @Author: smarthane
/// @GitHub: https://github.com/smarthane
/// @Description:
/// @Date: 2020/11/29

class TestState implements Cloneable<TestState> {
  @override
  TestState clone() {
    return TestState();
  }
}

TestState initState(Map<String, dynamic> args) {
  return TestState();
}
