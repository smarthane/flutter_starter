import 'package:bot_toast/bot_toast.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart' hide Action, Page;
import 'package:flutter/material.dart' hide Action, Page;
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_starter/global_store/state.dart';
import 'package:flutter_starter/route/route.dart';
import 'package:flutter_starter/widget/widget_pageroute_anim.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'generated/l10n.dart';

/// @Author: smarthane
/// @GitHub: https://github.com/smarthane
/// @Description:
/// @Date: 2020/11/29

/// effect
Effect<AppState> buildEffect() {
  return combineEffects(<Object, Effect<AppState>>{
    Lifecycle.initState: _onInitState,
  });
}

/// 初始化应用相关
void _onInitState(Action action, Context<AppState> ctx) {}

/// state
class AppState implements Cloneable<AppState>, GlobalBaseState {
  @override
  AppState clone() {
    return AppState()..store = store;
  }

  @override
  StoreModel store;
}

AppState initState(Map<String, dynamic> args) {
  return AppState();
}

/// view
Widget buildView(AppState state, Dispatch dispatch, ViewService viewService) {
  return MaterialApp(
    title: "",
    /// 初始化BotToast
    builder: BotToastInit(),
    navigatorObservers: [BotToastNavigatorObserver()],
    /// 作为默认页面
    home: RouteManager.routes.buildPage(RouteManager.splashPage, null),
    /// 主题 包括颜色 字体 黑夜模式
    theme: state.store.themeModel.themeData,
    /// 路由
    onGenerateRoute: (RouteSettings settings) {
      /// 无页面切换动画
      if (settings.name == RouteManager.appPage ||
          settings.name == RouteManager.splashPage ||
          settings.name == RouteManager.webViewPage) {
        return NoAnimRouteBuilder(
            RouteManager.routes.buildPage(settings.name, settings.arguments));
      } else {
        /// ios页面切换风格
        return CupertinoPageRoute(builder: (BuildContext context) {
          return RouteManager.routes
              .buildPage(settings.name, settings.arguments);
        });
      }
    },
    /// 国际化
    locale: state.store.localeModel.locale,
    localizationsDelegates: const [
      S.delegate,
      // 下拉刷新
      RefreshLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate
    ],
    supportedLocales: S.delegate.supportedLocales,
  );
}

/// page
class AppPage extends Page<AppState, Map<String, dynamic>> {
  AppPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          view: buildView,
          dependencies: Dependencies<AppState>(
              adapter: null, slots: <String, Dependent<AppState>>{}),
          middleware: <Middleware<AppState>>[],
        );
}
