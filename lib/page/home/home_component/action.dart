import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_starter/api/model/article_model.dart';

/// @Author: smarthane
/// @GitHub: https://github.com/smarthane
/// @Description:
/// @Date: 2020/11/29

enum TabHomeAction {
  /// 下拉刷新
  EFFECT_ON_REFRESH,
  REDUCER_ON_REFRESH,

  /// 加载数据
  EFFECT_ON_LOAD,
  REDUCER_ON_LOAD,

  /// 打开webview页面
  OPEN_WEBVIEW_PAGE,

  /// 滚动到顶部
  SCROLL_TO_TOP,
}

class TabHomeActionCreator {
  static Action onOpenWebviewPage(String title, String url) {
    return Action(TabHomeAction.OPEN_WEBVIEW_PAGE,
        payload: {"title": title, "url": url});
  }

  static Action onEffectRefresh() {
    return const Action(TabHomeAction.EFFECT_ON_REFRESH);
  }

  static Action onReducerRefresh() {
    return const Action(TabHomeAction.REDUCER_ON_REFRESH);
  }

  static Action onEffectLoad(int pageNum) {
    return Action(TabHomeAction.EFFECT_ON_LOAD, payload: pageNum);
  }

  static Action onReducerLoad(List<Article> articles) {
    return Action(TabHomeAction.REDUCER_ON_LOAD, payload: articles);
  }

  static Action onScrollToTop(bool isTop) {
    return Action(TabHomeAction.SCROLL_TO_TOP, payload: isTop);
  }
}
