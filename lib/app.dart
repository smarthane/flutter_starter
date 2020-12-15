import 'package:bot_toast/bot_toast.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart' hide Action, Page;
import 'package:flutter/material.dart' hide Action, Page;
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_starter/broadcast/action.dart';
import 'package:flutter_starter/common/notifications_manager.dart';
import 'package:flutter_starter/global_store/state.dart';
import 'package:flutter_starter/route/route.dart';
import 'package:flutter_starter/util/log_utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'generated/l10n.dart';

/// @Author: smarthane
/// @GitHub: https://github.com/smarthane
/// @Description: application 做一些应用的全局工作
/// @Date: 2020/11/29

/// effect
Effect<AppState> buildEffect() {
  return combineEffects(<Object, Effect<AppState>>{
    Lifecycle.initState: _onInitState,
    BroadcastAction.NOTIFY_APP_NOTIFICATIONS: _receiveNotifyAppNotification,
    BroadcastAction.NOTIFY_SYS_NOTIFICATIONS: _receiveNotifySysNotification
  });
}

/// 初始化应用相关
void _onInitState(Action action, Context<AppState> ctx) {
  LogUtils.v(" App onInitState ------ > success");
}

/// 接收弹出 应用 内 消息通知
void _receiveNotifyAppNotification(Action action, Context<AppState> ctx) {
  BotToast.showNotification(
      leading: (cancel) => SizedBox.fromSize(
          size: const Size(40, 40),
          child: IconButton(
            icon: Icon(Icons.info, color: Colors.redAccent),
            onPressed: cancel,
          )),
      title: (_) => Text('这是提示消息标题'),
      subtitle: (_) => Text("这是内容：${action.payload}"),
      trailing: (cancel) => IconButton(
            icon: Icon(Icons.cancel),
            onPressed: cancel,
          ),
      onTap: () {
        BotToast.showText(text: 'Tap toast');
      },
      onLongPress: () {
        BotToast.showText(text: 'Long press toast');
      },
      enableSlideOff: true,
      backButtonBehavior: BackButtonBehavior.none,
      crossPage: true,
      contentPadding: EdgeInsets.all(2),
      onlyOne: true,
      animationDuration: Duration(milliseconds: 200),
      animationReverseDuration: Duration(milliseconds: 200),
      duration: Duration(seconds: 3));
}

/// 接收弹出 系统 内 消息通知
void _receiveNotifySysNotification(Action action, Context<AppState> ctx) {
  NotificationsManager.showNotification(action.payload);
}

/// state
class AppState implements Cloneable<AppState>, GlobalBaseState {
  @override
  AppState clone() {
    return AppState()..store = store;
  }

  @override
  StoreModel store;
}

/// init state
AppState initState(Map<String, dynamic> args) {
  return AppState();
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

/// view
Widget buildView(AppState state, Dispatch dispatch, ViewService viewService) {
  LogUtils.v(" App buildView ------ > success");
  return MaterialApp(
    title: "",

    /// 初始化BotToast
    builder: BotToastInit(),
    navigatorObservers: [BotToastNavigatorObserver(), FsNavigatorObserver()],

    /// 作为默认页面
    home: RouteManager.routes.buildPage(RouteManager.splashPage, null),

    /// 主题 包括颜色 字体 黑夜模式
    theme: state.store.themeModel.themeData,

    /// 路由
    onGenerateRoute: (RouteSettings settings) {
      return RouteManager.pageRouteFilter(settings);
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
