import 'package:fish_redux/fish_redux.dart';

/// @Author: smarthane
/// @GitHub: https://github.com/smarthane
/// @Description: 应用内广播 实现类似 安卓evenbus功能
/// @Date: 2020/11/29

enum BroadcastAction {
  NOTIFY_APP_NOTIFICATIONS,
  NOTIFY_SYS_NOTIFICATIONS,
  toNotify
}

class BroadcastActionCreator {

  ///全局 弹出 广播通知 应用内
  static Action notifyAppNotifications(Object payload) {
    return Action(BroadcastAction.NOTIFY_APP_NOTIFICATIONS, payload: payload);
  }

  ///全局 弹出 广播通知 系统
  static Action notifySysNotifications(Object payload) {
    return Action(BroadcastAction.NOTIFY_SYS_NOTIFICATIONS, payload: payload);
  }

  ///广播通知
  static Action toNotify(String msg) {
    return Action(BroadcastAction.toNotify, payload: msg);
  }
}
