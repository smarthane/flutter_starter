import 'package:fish_redux/fish_redux.dart';

/// @Author: smarthane
/// @GitHub: https://github.com/smarthane
/// @Description:
/// @Date: 2020/11/29
///
enum BaseComponentsAction { action }

class BaseComponentsActionCreator {
  static Action onAction(int index) {
    return Action(BaseComponentsAction.action, payload: index);
  }
}
