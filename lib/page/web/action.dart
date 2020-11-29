import 'package:fish_redux/fish_redux.dart';

/// @Author: smarthane
/// @GitHub: https://github.com/smarthane
/// @Description:
/// @Date: 2020/11/29

enum WebviewAction { action }

class WebviewActionCreator {
  static Action onAction() {
    return const Action(WebviewAction.action);
  }
}
