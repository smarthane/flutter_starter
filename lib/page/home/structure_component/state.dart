import 'package:fish_redux/fish_redux.dart';

/// @Author: smarthane
/// @GitHub: https://github.com/smarthane
/// @Description:
/// @Date: 2020/11/29

class TabStructureState implements Cloneable<TabStructureState> {
  @override
  TabStructureState clone() {
    return TabStructureState();
  }
}

TabStructureState initState(Map<String, dynamic> args) {
  return TabStructureState();
}
