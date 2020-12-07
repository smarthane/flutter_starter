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
/// @Description:
/// @Date: 2020/11/29

void main() {
  startApp();
}

/// 启动应用
void startApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initializationComponents();
  runApp(IGlobalStore(
    globalState: GlobalStore.store.getState(),
    child: RouteManager.routes.buildPage(RouteManager.appPage, null),
  ));
  /// Android状态栏透明 splash为白色,所以调整状态栏文字为黑色
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light));
}

/// 组件初始化写在此方法中
Future _initializationComponents() async {
  await StorageManager.init();
  await NotificationsManager.init();
  await AppManager.init();
  return Future.value(true);
}