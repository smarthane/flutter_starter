import 'package:fish_redux/fish_redux.dart';

/// @Author: smarthane
/// @GitHub: https://github.com/smarthane
/// @Description:
/// @Date: 2020/11/29

enum SettingAction { SWITCH_WEBVIEW_MODE, action }

class SettingActionCreator {
  static Action onAction() {
    return const Action(SettingAction.action);
  }

  static Action onSwitchWebviewMode() {
    return const Action(SettingAction.SWITCH_WEBVIEW_MODE);
  }
}
