import 'package:fish_redux/fish_redux.dart';

/// @Author: smarthane
/// @GitHub: https://github.com/smarthane
/// @Description:
/// @Date: 2020/11/29

enum ArticleAction {
  EACTION_ON_REFRESH,
  RACTION_ON_REFRESH,
  EACTION_ON_LOAD,
  RACTION_ON_LOAD,
  OPEN_WEBVIEW_PAGE,
}

class ArticleActionCreator {
  static Action onEActionRefresh(int index) {
    return Action(ArticleAction.EACTION_ON_REFRESH, payload: index);
  }

  static Action onEActionLoad(int pageNum) {
    return Action(ArticleAction.EACTION_ON_LOAD, payload: pageNum);
  }

  static Action onRActionRefresh() {
    return const Action(ArticleAction.RACTION_ON_REFRESH);
  }

  static Action onRActionLoad() {
    return const Action(ArticleAction.RACTION_ON_LOAD);
  }

  static Action onOpenWebviewPage(String title, String url) {
    return Action(ArticleAction.OPEN_WEBVIEW_PAGE,
        payload: {"title": title, "url": url});
  }
}
