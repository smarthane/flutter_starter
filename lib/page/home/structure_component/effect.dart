import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_starter/api/model/navigation_site_model.dart';
import 'package:flutter_starter/api/model/tree_model.dart';
import 'package:flutter_starter/api/wanandroid_api_helper.dart';
import 'package:flutter_starter/page/home/structure_component/component.dart';
import 'package:flutter_starter/route/route.dart';
import 'action.dart';
import 'state.dart';

Effect<TabStructureState> buildEffect() {
  return combineEffects(<Object, Effect<TabStructureState>>{
    Lifecycle.initState: _onInitState,
    Lifecycle.dispose: _onDispose,
    Lifecycle.didChangeDependencies: _onDidChangeDependencies,
    TabStructureAction.OPEN_WEBVIEW_PAGE: _onOpenWebviewPage,
    TabStructureAction.OPEN_ARTICLE_PAGE: _onOpenArticlePage,
    TabStructureAction.E_ACTION_LOAD_STRUCTURE_CATEGORY:
        _onLoadStructureCategory,
    TabStructureAction.E_ACTION_LOAD_NAVIGATION_SITE_CATEGORY:
        _onLoadNavigationSiteCategory,
  });
}

/// 初始化
void _onInitState(Action action, Context<TabStructureState> ctx) {
  final TickerProvider tickerProvider = ctx.stfState as StateWithTickerProvider;
  final TabController _tabController =
      TabController(length: ctx.state.tabs.length, vsync: tickerProvider);
  _tabController.addListener(() {
    var tabIndex = _tabController.index;
    if (ctx.state.currentTabIndex != tabIndex) {
      ctx.state.currentTabIndex = tabIndex;
      if (tabIndex == 0) {
        if (ctx.state.treeList.isEmpty) {
          ctx.dispatch(
              TabStructureActionCreator.onEActionLoadStructureCategory());
          ctx.dispatch(
              TabStructureActionCreator.onRActionLoadStructureCategory());
        }
      } else if (tabIndex == 1) {
        if (ctx.state.navigationSiteList.isEmpty) {
          ctx.dispatch(
              TabStructureActionCreator.onEActionLoadNavigationSiteCategory());
          ctx.dispatch(
              TabStructureActionCreator.onRActionLoadNavigationSiteCategory());
        }
      }
    }
  });
  if (ctx.state.tabController == null) {
    ctx.state.tabController = _tabController;
  }
  ctx.dispatch(TabStructureActionCreator.onEActionLoadStructureCategory());
}

/// didChangeDependencies
void _onDidChangeDependencies(Action action, Context<TabStructureState> ctx) {}

/// dispose
void _onDispose(Action action, Context<TabStructureState> ctx) {}

void _onLoadStructureCategory(Action action, Context<TabStructureState> ctx) {
  ctx.state.treeViewStateMode.setLoad();
  WanandroidApiHelper.fetchTreeCategories().then((response) {
    if (response.code == WanandroidResponse.SUCCESS_CODE) {
      var result =
          response.data.map<Tree>((item) => Tree.fromJsonMap(item)).toList();
      ctx.state.treeList = result;
      ctx.state.treeViewStateMode.setSuccess();
    } else {
      ctx.state.treeViewStateMode.setError();
    }
    ctx.dispatch(TabStructureActionCreator.onRActionLoadStructureCategory());
  });
}

void _onLoadNavigationSiteCategory(
    Action action, Context<TabStructureState> ctx) {
  ctx.state.siteViewStateMode.setLoad();
  WanandroidApiHelper.fetchNavigationSite().then((response) {
    if (response.code == WanandroidResponse.SUCCESS_CODE) {
      var result = response.data
          .map<NavigationSite>((item) => NavigationSite.fromMap(item))
          .toList();
      ctx.state.navigationSiteList = result;
      ctx.state.siteViewStateMode.setSuccess();
    } else {
      ctx.state.siteViewStateMode.setError();
    }
    ctx.dispatch(
        TabStructureActionCreator.onRActionLoadNavigationSiteCategory());
  });
}

/// 打开webview查看详情
void _onOpenWebviewPage(Action action, Context<TabStructureState> ctx) {
  Navigator.pushNamed(ctx.context, RouteManager.webViewPage,
      arguments: action.payload);
}

/// 打开体系--> 选择相关知识点的详情页
void _onOpenArticlePage(Action action, Context<TabStructureState> ctx) {
  Navigator.pushNamed(ctx.context, RouteManager.articlePage,
      arguments: action.payload);
}
