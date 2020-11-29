import 'package:fish_redux/fish_redux.dart';

/// @Author: smarthane
/// @GitHub: https://github.com/smarthane
/// @Description:
/// @Date: 2020/11/29

class DemosState implements Cloneable<DemosState> {

  @override
  DemosState clone() {
    return DemosState();
  }
}

DemosState initState(Map<String, dynamic> args) {
  return DemosState();
}
