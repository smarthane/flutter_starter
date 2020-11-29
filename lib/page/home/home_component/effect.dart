import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_starter/api/wanandroid_api_helper.dart';
import 'package:flutter_starter/route/route.dart';
import 'action.dart';
import 'state.dart';

/// @Author: smarthane
/// @GitHub: https://github.com/smarthane
/// @Description:
/// @Date: 2020/11/29

Effect<TabHomeState> buildEffect() {
  return combineEffects(<Object, Effect<TabHomeState>>{
    Lifecycle.initState: _onInitState,
    Lifecycle.dispose: _onDispose,
    Lifecycle.didChangeDependencies: _onDidChangeDependencies,
    TabHomeAction.EFFECT_ON_REFRESH: _onRefresh,
    TabHomeAction.EFFECT_ON_LOAD: _onLoad,
    TabHomeAction.OPEN_WEBVIEW_PAGE: _onOpenWebviewPage,
  });
}

/// 初始化
void _onInitState(Action action, Context<TabHomeState> ctx) {
  ctx.dispatch(TabHomeActionCreator.onEffectRefresh());
}

/// 初始化
void _onDidChangeDependencies(Action action, Context<TabHomeState> ctx) {
  /// 使用PrimaryScrollController保留iOS点击状态栏回到顶部的功能
  ScrollController _scrollController = PrimaryScrollController.of(ctx.context);
  _scrollController.addListener(() {
    if (_scrollController.offset > TabHomeState.tapToTopLimitHeight &&
        !ctx.state.showTopBtn) {
      ctx.dispatch(TabHomeActionCreator.onScrollToTop(true));
    } else if (_scrollController.offset < TabHomeState.tapToTopLimitHeight &&
        ctx.state.showTopBtn) {
      ctx.dispatch(TabHomeActionCreator.onScrollToTop(false));
    }
  });
  ctx.state.scrollController = _scrollController;
}

/// dispose
void _onDispose(Action action, Context<TabHomeState> ctx) {}

/// 下拉刷新
void _onRefresh(Action action, Context<TabHomeState> ctx) {
  List<Future> futures = [
    WanandroidApiHelper.fetchBanners(),
    WanandroidApiHelper.fetchTopArticles(),
    WanandroidApiHelper.fetchArticles(TabHomeState.pageNumFirst)
  ];
  Future.wait(futures).then((result) {
    ctx.state.banners = result[0];
    ctx.state.articles = result[1];
    ctx.state.articles.addAll(result[2]);
    ctx.dispatch(TabHomeActionCreator.onReducerRefresh());
  });
}

/// 上拉加载更多数据
void _onLoad(Action action, Context<TabHomeState> ctx) {
  WanandroidApiHelper.fetchArticles(action.payload).then((result) {
    ctx.dispatch(TabHomeActionCreator.onReducerLoad(result));
  });
}

/// 打开webview查看详情
void _onOpenWebviewPage(Action action, Context<TabHomeState> ctx) {
  Navigator.pushNamed(ctx.context, RouteManager.webViewPage,
      arguments: action.payload);
}