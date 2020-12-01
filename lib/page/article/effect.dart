import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_starter/api/model/article_model.dart';
import 'package:flutter_starter/api/wanandroid_api_helper.dart';
import 'package:flutter_starter/page/article/page.dart';
import 'package:flutter_starter/route/route.dart';

import 'action.dart';
import 'state.dart';

/// @Author: smarthane
/// @GitHub: https://github.com/smarthane
/// @Description:
/// @Date: 2020/11/29

Effect<ArticleState> buildEffect() {
  return combineEffects(<Object, Effect<ArticleState>>{
    Lifecycle.initState: _onInitState,
    Lifecycle.dispose: _onDispose,
    Lifecycle.didChangeDependencies: _onDidChangeDependencies,
    ArticleAction.OPEN_WEBVIEW_PAGE: _onOpenWebviewPage,
    ArticleAction.EACTION_ON_REFRESH: _onRefresh,
    ArticleAction.EACTION_ON_LOAD: _onLoad,
  });
}

/// 初始化
void _onInitState(Action action, Context<ArticleState> ctx) {
  final TickerProvider tickerProvider = ctx.stfState as StateWithTickerProvider;
  final TabController _tabController = TabController(
      length: ctx.state.tree.children.length, vsync: tickerProvider);
  _tabController.addListener(() {
    var tabIndex = _tabController.index;
    if (ctx.state.tabIndex != tabIndex) {
      var data = ctx.state.datas[ctx.state.idList[tabIndex]];
      ctx.state.tabIndex = tabIndex;
      if (data.articles.isEmpty) {
        ctx.dispatch(ArticleActionCreator.onRActionRefresh());
        ctx.dispatch(ArticleActionCreator.onEActionRefresh(tabIndex));
      }
    }
  });
  ctx.state.tabController = _tabController;
  if (ctx.state.tree != null && ctx.state.tree.children.isNotEmpty) {
    ctx.state.tree.children.forEach((element) {
      ctx.state.idList.add(element.id);
      ctx.state.datas.putIfAbsent(element.id, () => ArticleItemData());
    });
  }
  _tabController.animateTo(ctx.state.tabIndex);
  ctx.dispatch(ArticleActionCreator.onEActionRefresh(ctx.state.tabIndex));
}

/// didChangeDependencies
void _onDidChangeDependencies(Action action, Context<ArticleState> ctx) {}

/// dispose
void _onDispose(Action action, Context<ArticleState> ctx) {}

void _onRefresh(Action action, Context<ArticleState> ctx) {
  var index = action.payload;
  var id = ctx.state.idList[index];
  ArticleItemData item = ctx.state.datas[id];
  item.pageNum = ArticleItemData.pageNumFirst;
  item.setLoad();
  WanandroidApiHelper.fetchArticles(item.pageNum, cid: id).then((response) {
    if (response.code == WanandroidResponse.SUCCESS_CODE) {
      var result = response.data['datas']
          .map<Article>((item) => Article.fromMap(item))
          .toList();
      if (result.isEmpty) {
        item.setEmpty();
      } else {
        item.articles = result;
        item.setSuccess();
      }
      ctx.dispatch(ArticleActionCreator.onRActionRefresh());
    } else {
      item.setError();
      ctx.dispatch(ArticleActionCreator.onRActionRefresh());
    }
  });
}

void _onLoad(Action action, Context<ArticleState> ctx) {
  int index = action.payload;
  ctx.state.tabIndex = index;
  int id = ctx.state.idList[index];
  ArticleItemData data = ctx.state.datas[id];
  data.pageNum += 1;
  data.setLoad();
  WanandroidApiHelper.fetchArticles(data.pageNum, cid: id)
      .then((response) {
    if (response.code == WanandroidResponse.SUCCESS_CODE) {
      var result = response.data['datas']
          .map<Article>((item) => Article.fromMap(item))
          .toList();
      data.articles.addAll(result);
      data.setSuccess();
      ctx.dispatch(ArticleActionCreator.onRActionLoad());
    } else {
      data.setError();
      ctx.dispatch(ArticleActionCreator.onRActionLoad());
    }
  });
}

/// 打开webview查看详情
void _onOpenWebviewPage(Action action, Context<ArticleState> ctx) {
  Navigator.pushNamed(ctx.context, RouteManager.webViewPage,
      arguments: action.payload);
}
