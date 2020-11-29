import 'package:fish_redux/fish_redux.dart';

/// @Author: smarthane
/// @GitHub: https://github.com/smarthane
/// @Description:
/// @Date: 2020/11/29

enum TabProjectAction {
  ACTION_TAB_DATA,

  /// 下拉刷新
  EFFECT_ON_REFRESH,
  REDUCER_ON_REFRESH,

  /// 加载数据
  EFFECT_ON_LOAD,
  REDUCER_ON_LOAD,

  /// 打开webview页面
  OPEN_WEBVIEW_PAGE,
  action
}

class TabProjectActionCreator {
  static Action onOpenWebviewPage(String title, String url) {
    return Action(TabProjectAction.OPEN_WEBVIEW_PAGE,
        payload: {"title": title, "url": url});
  }

  static Action onTabDataAction() {
    return const Action(TabProjectAction.ACTION_TAB_DATA);
  }

  static Action onEffectRefresh(int index) {
    return Action(TabProjectAction.EFFECT_ON_REFRESH, payload: index);
  }

  static Action onReducerRefresh() {
    return const Action(TabProjectAction.REDUCER_ON_REFRESH);
  }

  static Action onEffectLoad(int index) {
    return Action(TabProjectAction.EFFECT_ON_LOAD, payload: index);
  }

  static Action onReducerLoad() {
    return const Action(TabProjectAction.REDUCER_ON_LOAD);
  }

  static Action onAction() {
    return const Action(TabProjectAction.action);
  }
}
