import 'package:fish_redux/fish_redux.dart';

/// @Author: smarthane
/// @GitHub: https://github.com/smarthane
/// @Description:
/// @Date: 2020/11/29

//TODO replace with your own action
enum DemosAction { action }

class DemosActionCreator {
  static Action onAction() {
    return const Action(DemosAction.action);
  }
}
