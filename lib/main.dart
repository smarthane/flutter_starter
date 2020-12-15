import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide Action, Page;
import 'package:flutter/services.dart';
import 'package:flutter_starter/common/app_manager.dart';
import 'package:flutter_starter/common/storage_manager.dart';
import 'package:flutter_starter/route/route.dart';

import 'common/notifications_manager.dart';
import 'global_store/store.dart';

/// @Author: smarthane
/// @GitHub: https://github.com/smarthane
/// @Description: main
/// @Date: 2020/11/29

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  /// run zone 全局异常捕获
  runZoned(
    () => startApp(),
    zoneSpecification: ZoneSpecification(
      print: (Zone self, ZoneDelegate parent, Zone zone, String line) {
        /// TODO 收集日志
      },
    ),
    onError: (Object obj, StackTrace stack) {
      /// TODO  上报错误和日志逻辑
    },
  );
}

/// 启动应用
void startApp() async {
  /// 组件初始化
  await _initializationComponents();

  /// 启动app
  runApp(IGlobalStore(
    globalState: GlobalStore.store.getState(),
    child: RouteManager.routes.buildPage(RouteManager.appPage, null),
  ));

  /// 设置android状态栏为透明的沉浸。
  if (Platform.isAndroid) {
    /// Android状态栏透明 splash为白色,所以调整状态栏文字为黑色
    /// 必须写在组件渲染之后。
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light));
  }
}

/// 组件初始化写在此方法中
Future _initializationComponents() async {
  await StorageManager.init();
  await NotificationsManager.init();
  await AppManager.init();
  return Future.value(true);
}
