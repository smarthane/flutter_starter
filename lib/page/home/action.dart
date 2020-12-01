import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;

/// @Author: smarthane
/// @GitHub: https://github.com/smarthane
/// @Description:
/// @Date: 2020/11/29

enum HomeAction {
  /// 切换主题
  SWITCH_THEME,

  /// 切换语言
  SWITCH_LOCALE,

  /// 切换黑夜模式
  SWITCH_DARK_MODE,

  /// 切换字体库
  SWITCH_FONT_FAMILY,

  /// 退出应用
  ANDROID_EXIT_APP,

  /// 登录页面
  START_LOGIN_PAGE,

  /// 退出登录
  ACTION_LOGOUT,

  /// TAB页面跳转
  JUMP_TAB_PAGE,

  /// Demos页面
  START_DEMOS_PAGE,

  /// 设置页面
  START_SETTING_PAGE,
}

class HomeActionCreator {
  static Action switchTheme(MaterialColor themeColor) {
    return Action(HomeAction.SWITCH_THEME, payload: themeColor);
  }

  static Action switchDarkMode(bool darkMode) {
    return Action(HomeAction.SWITCH_DARK_MODE, payload: darkMode);
  }

  static Action switchLocale(int index) {
    return Action(HomeAction.SWITCH_LOCALE, payload: index);
  }

  static Action switchFontFamily(int index) {
    return Action(HomeAction.SWITCH_FONT_FAMILY, payload: index);
  }

  static Action androidExitApp() {
    return const Action(HomeAction.ANDROID_EXIT_APP);
  }

  static Action startLoginPage() {
    return const Action(HomeAction.START_LOGIN_PAGE);
  }

  static Action logout() {
    return const Action(HomeAction.ACTION_LOGOUT);
  }

  static Action startDemosPage() {
    return const Action(HomeAction.START_DEMOS_PAGE);
  }

  static Action startSettingPage() {
    return const Action(HomeAction.START_SETTING_PAGE);
  }

  static Action jumpTabPage(int index) {
    return Action(HomeAction.JUMP_TAB_PAGE, payload: index);
  }
}
