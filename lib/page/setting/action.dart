import 'package:fish_redux/fish_redux.dart';

/// @Author: smarthane
/// @GitHub: https://github.com/smarthane
/// @Description:
/// @Date: 2020/11/29

enum SettingAction {
  SWITCH_WEBVIEW_MODE,
  /// 打开webview页面
  OPEN_WEBVIEW_PAGE,
  /// 打开意见反馈页面
  OPEN_FEEDBACK_PAGE,
  /// 打开关于我页面
  OPEN_ABOUTME_PAGE,
}

class SettingActionCreator {

  static Action onOpenWebviewPage(String title, String url) {
    return Action(SettingAction.OPEN_WEBVIEW_PAGE,
        payload: {"title": title, "url": url});
  }

  static Action onSwitchWebviewMode() {
    return const Action(SettingAction.SWITCH_WEBVIEW_MODE);
  }

  static Action onOpenFeedbackPage() {
    return const Action(SettingAction.OPEN_FEEDBACK_PAGE);
  }

  static Action onOpenAboutMePage() {
    return const Action(SettingAction.OPEN_ABOUTME_PAGE);
  }
}
