import 'package:bot_toast/bot_toast.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_starter/api/wanandroid_api_helper.dart';
import 'package:flutter_starter/common/app_manager.dart';
import 'package:flutter_starter/common/storage_manager.dart';
import 'package:flutter_starter/global_store/action.dart';
import 'package:flutter_starter/global_store/store.dart';
import 'package:flutter_starter/route/route.dart';

import 'action.dart';
import 'state.dart';

/// @Author: smarthane
/// @GitHub: https://github.com/smarthane
/// @Description:
/// @Date: 2020/11/29

Effect<HomeState> buildEffect() {
  return combineEffects(<Object, Effect<HomeState>>{
    Lifecycle.initState: _onInitState,
    Lifecycle.dispose: _onDispose,
    HomeAction.SWITCH_THEME: _switchTheme,
    HomeAction.SWITCH_DARK_MODE: _switchDarkMode,
    HomeAction.SWITCH_FONT_FAMILY: _switchFontFamily,
    HomeAction.SWITCH_LOCALE: _switchLocale,
    HomeAction.START_LOGIN_PAGE: _startLoginPage,
    HomeAction.ACTION_LOGOUT: _logout,
    HomeAction.START_DEMOS_PAGE: _startDemosPage,
    HomeAction.START_SETTING_PAGE: _startSettingPage,
  });
}

/// 初始化
void _onInitState(Action action, Context<HomeState> ctx) {
  List<Widget> pages = <Widget>[
    ctx.buildComponent("tabHome"),
    ctx.buildComponent("tabProject"),
    ctx.buildComponent("tabStructure"),
    ctx.buildComponent("tabLegend"),
  ];
  ctx.state.tabPages = pages;
}

/// dispose
void _onDispose(Action action, Context<HomeState> ctx) {}

///全局切换主题
void _switchTheme(Action action, Context<HomeState> ctx) {
  var payload = {"context": ctx.context, "themeColor": action.payload};
  GlobalStore.store.dispatch(GlobalActionCreator.onSwitchTheme(payload));
}

///全局 设置 黑夜模式
void _switchDarkMode(Action action, Context<HomeState> ctx) {
  var payload = {"context": ctx.context, "darkMode": action.payload};
  GlobalStore.store.dispatch(GlobalActionCreator.onSwitchDarkMode(payload));
}

///全局 切换字体库
void _switchFontFamily(Action action, Context<HomeState> ctx) {
  var payload = {"context": ctx.context, "index": action.payload};
  GlobalStore.store.dispatch(GlobalActionCreator.onSwitchFontFamily(payload));
}

///全局 切换语言
void _switchLocale(Action action, Context<HomeState> ctx) {
  var payload = {"context": ctx.context, "index": action.payload};
  GlobalStore.store.dispatch(GlobalActionCreator.onSwitchLocale(payload));
}

///打开登录页面
void _startLoginPage(Action action, Context<HomeState> ctx) {
  Navigator.pushNamed(ctx.context, RouteManager.loginPage);
}

///打开开发示例页面
void _startDemosPage(Action action, Context<HomeState> ctx) {
  Navigator.pushNamed(ctx.context, RouteManager.demosPage);
}

///打开设置页面
void _startSettingPage(Action action, Context<HomeState> ctx) {
  Navigator.pushNamed(ctx.context, RouteManager.settingPage);
}

///退出登录
void _logout(Action action, Context<HomeState> ctx) {
  /// BotToast.showLoading();
  WanandroidApiHelper.logout().then((response) {
    ctx.state.store.userModel.user = null;
    StorageManager.localStorage.deleteItem(Constants.KEY_USER_INFO);
    GlobalStore.store.dispatch(GlobalActionCreator.onUpdateUserInfo(true));
  });
}
