import 'package:fish_redux/fish_redux.dart';

/// @Author: smarthane
/// @GitHub: https://github.com/smarthane
/// @Description:
/// @Date: 2020/11/29

enum GlobalAction {
  /// 切换主题
  SWITCH_THEME,

  /// 切换语言
  SWITCH_LOCALE,

  /// 切换黑夜模式
  SWITCH_DARK_MODE,

  /// 切换字体库
  SWITCH_FONT_FAMILY,

  /// 切换字体库
  UPDATE_USER_INFO,
}

class GlobalActionCreator {
  static Action onSwitchTheme(Object payload) {
    return Action(GlobalAction.SWITCH_THEME, payload: payload);
  }

  static Action onSwitchLocale(Object payload) {
    return Action(GlobalAction.SWITCH_LOCALE, payload: payload);
  }

  static Action onSwitchDarkMode(Object payload) {
    return Action(GlobalAction.SWITCH_DARK_MODE, payload: payload);
  }

  static Action onSwitchFontFamily(Object payload) {
    return Action(GlobalAction.SWITCH_FONT_FAMILY, payload: payload);
  }

  static Action onUpdateUserInfo(Object payload) {
    return Action(GlobalAction.UPDATE_USER_INFO, payload: payload);
  }
}
