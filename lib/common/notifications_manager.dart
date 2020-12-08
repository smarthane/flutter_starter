
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_starter/util/toast_utils.dart';
import 'package:permission_handler/permission_handler.dart';

/// @Author: smarthane
/// @GitHub: https://github.com/smarthane
/// @Description: 消息通知管理工具. 支持  安卓 ios
/// 基于https://github.com/MaikuB/flutter_local_notifications
/// @Date: 2020/11/21

class NotificationsManager {

  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  static init() async {
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    var android = new AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOS = new IOSInitializationSettings();
    var initSetttings = new InitializationSettings(android: android, iOS: iOS);
    flutterLocalNotificationsPlugin.initialize(initSetttings, onSelectNotification: _onSelectNotification);
  }

  static Future _onSelectNotification(String payload) {
    /// 点击 路由到 具体页面
    ToastUtils.showText(payload);
  }

  static showNotification(Object payload) async {
    /// 得有 权限 才能弹
    if(await Permission.notification.request().isGranted) {
      var android = new AndroidNotificationDetails(
          'channel id', 'channel NAME', 'CHANNEL DESCRIPTION',
          priority: Priority.high,importance: Importance.max
      );
      var iOS = new IOSNotificationDetails();
      var platform = new NotificationDetails(android: android, iOS: iOS);
      await flutterLocalNotificationsPlugin.show(
          0, 'New Video is out', 'Flutter Local Notification', platform,
          payload: 'Nitish Kumar Singh is part time Youtuber');
    }
  }

}