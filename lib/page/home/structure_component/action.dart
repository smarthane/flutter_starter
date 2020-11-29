import 'package:fish_redux/fish_redux.dart';

/// @Author: smarthane
/// @GitHub: https://github.com/smarthane
/// @Description:
/// @Date: 2020/11/29

enum TabStructureAction { action }

class TabStructureActionCreator {
  static Action onAction() {
    return const Action(TabStructureAction.action);
  }
}
