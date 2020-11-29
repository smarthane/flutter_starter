import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_starter/api/model/tree_model.dart';

/// @Author: smarthane
/// @GitHub: https://github.com/smarthane
/// @Description:
/// @Date: 2020/11/29

enum TabStructureAction {
  E_ACTION_LOAD_STRUCTURE_CATEGORY,
  E_ACTION_LOAD_NAVIGATION_SITE_CATEGORY,
  R_ACTION_LOAD_STRUCTURE_CATEGORY,
  R_ACTION_LOAD_NAVIGATION_SITE_CATEGORY,

  /// 打开webview页面
  OPEN_WEBVIEW_PAGE,
  /// 打开体系--> 选择相关知识点的详情页
  OPEN_ARTICLE_PAGE,
}

class TabStructureActionCreator {
  static Action onEActionLoadStructureCategory() {
    return const Action(TabStructureAction.E_ACTION_LOAD_STRUCTURE_CATEGORY);
  }

  static Action onEActionLoadNavigationSiteCategory() {
    return const Action(
        TabStructureAction.E_ACTION_LOAD_NAVIGATION_SITE_CATEGORY);
  }

  static Action onRActionLoadStructureCategory() {
    return const Action(TabStructureAction.R_ACTION_LOAD_STRUCTURE_CATEGORY);
  }

  static Action onRActionLoadNavigationSiteCategory() {
    return const Action(
        TabStructureAction.R_ACTION_LOAD_NAVIGATION_SITE_CATEGORY);
  }

  static Action onOpenWebviewPage(String title, String url) {
    return Action(TabStructureAction.OPEN_WEBVIEW_PAGE,
        payload: {"title": title, "url": url});
  }

  static Action onOpenArticalPage(Tree tree, int index) {
    return Action(TabStructureAction.OPEN_ARTICLE_PAGE,
        payload: {"tree": tree, "index": index});
  }
}
