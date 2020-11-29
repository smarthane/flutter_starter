import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide Action, Page;
import 'package:flutter/services.dart';
import 'package:flutter_starter/common/storage_manager.dart';
import 'package:flutter_starter/route/route.dart';

import 'global_store/store.dart';

/// @Author: smarthane
/// @GitHub: https://github.com/smarthane
/// @Description:
/// @Date: 2020/11/29

void main() {
  startApp();
}

void startApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageManager.init();
  runApp(IGlobalStore(
    globalState: GlobalStore.store.getState(),
    child: RouteManager.routes.buildPage(RouteManager.appPage, null),
  ));
  // runApp(RouteManager.routes.buildPage(RouteManager.appPage, null));
  // Android状态栏透明 splash为白色,所以调整状态栏文字为黑色
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light));
}
