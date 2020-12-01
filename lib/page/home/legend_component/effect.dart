import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_starter/api/model/article_model.dart';
import 'package:flutter_starter/api/model/tree_model.dart';
import 'package:flutter_starter/api/wanandroid_api_helper.dart';
import 'package:flutter_starter/page/home/legend_component/component.dart';
import 'package:flutter_starter/route/route.dart';

import 'action.dart';
import 'state.dart';

/// @Author: smarthane
/// @GitHub: https://github.com/smarthane
/// @Description:
/// @Date: 2020/11/29

Effect<TabLegendState> buildEffect() {
  return combineEffects(<Object, Effect<TabLegendState>>{
    Lifecycle.initState: _onInitState,
    Lifecycle.dispose: _onDispose,
    TabLegendAction.OPEN_WEBVIEW_PAGE: _onOpenWebviewPage,
    TabLegendAction.EFFECT_ON_LOAD_TAB_DATA: _onEffectLoadTabData,
    TabLegendAction.EFFECT_ON_REFRESH: _onRefresh,
    TabLegendAction.EFFECT_ON_LOAD: _onLoad,
  });
}

/// 初始化
void _onInitState(Action action, Context<TabLegendState> ctx) {
  _onEffectLoadTabData(action, ctx);
}

/// 初始化
void _onEffectLoadTabData(Action action, Context<TabLegendState> ctx) {
  ctx.state.tabViewStateModel.setLoad();
  ctx.dispatch(TabLegendActionCreator.onReduceLoadTabData());
  WanandroidApiHelper.fetchWechatAccounts().then((response) {
    if (response.code == WanandroidResponse.SUCCESS_CODE) {
      var result =
          response.data.map<Tree>((item) => Tree.fromJsonMap(item)).toList();
      final TickerProvider tickerProvider =
          ctx.stfState as StateWithTickerProvider;
      final TabController _tabController =
          TabController(length: result.length, vsync: tickerProvider);
      _tabController.addListener(() {
        var tabIndex = _tabController.index;
        if (ctx.state.currentTabIndex != tabIndex) {
          ctx.state.currentTabIndex = tabIndex;
          var data = ctx.state.datas[ctx.state.idList[tabIndex]];
          if (data.articles.isEmpty) {
            ctx.dispatch(TabLegendActionCreator.onReducerRefresh());
            ctx.dispatch(TabLegendActionCreator.onEffectRefresh(tabIndex));
          }
        }
      });
      ctx.state.treeList = result;
      ctx.state.tabController = _tabController;
      ctx.state.treeList.forEach((element) {
        ctx.state.idList.add(element.id);
        ctx.state.datas.putIfAbsent(element.id, () => TabBarViewItemData());
      });
      ctx.state.tabViewStateModel.setSuccess();
      ctx.dispatch(TabLegendActionCreator.onReduceLoadTabData());
      ctx.dispatch(TabLegendActionCreator.onEffectRefresh(0));
    } else {
      ctx.state.tabViewStateModel.setError();
      ctx.dispatch(TabLegendActionCreator.onReduceLoadTabData());
    }
  });
}

/// dispose
void _onDispose(Action action, Context<TabLegendState> ctx) {
  ctx.state.tabController.dispose();
}

/// 下拉刷新
void _onRefresh(Action action, Context<TabLegendState> ctx) {
  int index = action.payload;
  int id = ctx.state.idList[action.payload];
  ctx.state.currentTabIndex = index;
  TabBarViewItemData data = ctx.state.datas[id];
  data.pageNum = TabBarViewItemData.pageNumFirst;
  data.setLoad();
  WanandroidApiHelper.fetchWechatAccountArticles(data.pageNum, id)
      .then((response) {
    if (response.code == WanandroidResponse.SUCCESS_CODE) {
      var result = response.data['datas']
          .map<Article>((item) => Article.fromMap(item))
          .toList();
      data.articles = result;
      data.setSuccess();
      ctx.dispatch(TabLegendActionCreator.onReducerRefresh());
    } else {
      data.setError();
      ctx.dispatch(TabLegendActionCreator.onReducerRefresh());
    }
  });
}

/// 上拉加载更多数据
void _onLoad(Action action, Context<TabLegendState> ctx) {
  int index = action.payload;
  ctx.state.currentTabIndex = index;
  int id = ctx.state.idList[index];
  TabBarViewItemData data = ctx.state.datas[id];
  data.pageNum += 1;
  data.setLoad();
  WanandroidApiHelper.fetchWechatAccountArticles(data.pageNum, id)
      .then((response) {
    if (response.code == WanandroidResponse.SUCCESS_CODE) {
      var result = response.data['datas']
          .map<Article>((item) => Article.fromMap(item))
          .toList();
      data.articles.addAll(result);
      data.setSuccess();
      ctx.dispatch(TabLegendActionCreator.onReducerLoad());
    } else {
      data.setError();
      ctx.dispatch(TabLegendActionCreator.onReducerLoad());
    }
  });
}

/// 打开webview查看详情
void _onOpenWebviewPage(Action action, Context<TabLegendState> ctx) {
  Navigator.pushNamed(ctx.context, RouteManager.webViewPage,
      arguments: action.payload);
}
