import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_starter/api/model/article_model.dart';
import 'package:flutter_starter/api/wanandroid_api_helper.dart';
import 'package:flutter_starter/api/model/tree_model.dart';
import 'package:flutter_starter/page/home/project_component/component.dart';
import 'package:flutter_starter/route/route.dart';
import 'action.dart';
import 'state.dart';

/// @Author: smarthane
/// @GitHub: https://github.com/smarthane
/// @Description:
/// @Date: 2020/11/29

Effect<TabProjectState> buildEffect() {
  return combineEffects(<Object, Effect<TabProjectState>>{
    Lifecycle.initState: _onInitState,
    Lifecycle.dispose: _onDispose,
    TabProjectAction.EFFECT_ON_LOAD_TAB_DATA: _onEffectLoadTabData,
    TabProjectAction.EFFECT_ON_REFRESH: _onRefresh,
    TabProjectAction.EFFECT_ON_LOAD: _onLoad,
    TabProjectAction.OPEN_WEBVIEW_PAGE: _onOpenWebviewPage,
  });
}

/// 初始化
void _onInitState(Action action, Context<TabProjectState> ctx) {
  _onEffectLoadTabData(action, ctx);
}

/// 加载tab数据
void _onEffectLoadTabData(Action action, Context<TabProjectState> ctx) {
  ctx.state.tabViewStateModel.setLoad();
  ctx.dispatch(TabProjectActionCreator.onReduceLoadTabData());
  WanandroidApiHelper.fetchProjectCategories().then((response) {
    if (response.code == WanandroidResponse.SUCCESS_CODE) {
      var result =
      response.data.map<Tree>((item) => Tree.fromJsonMap(item)).toList();
      final TickerProvider tickerProvider =
      ctx.stfState as StateWithTickerProvider;
      TabController _tabController =
      TabController(length: result.length, vsync: tickerProvider);
      _tabController.addListener(() {
        var tabIndex = _tabController.index;
        if (ctx.state.tabIndex != tabIndex) {
          ctx.state.tabIndex = tabIndex;
          var data = ctx.state.datas[ctx.state.cidList[tabIndex]];
          if (data.articles.isEmpty) {
            ctx.dispatch(TabProjectActionCreator.onReducerRefresh());
            ctx.dispatch(TabProjectActionCreator.onEffectRefresh(tabIndex));
          }
        }
      });
      ctx.state.treeList = result;
      ctx.state.tabController = _tabController;
      ctx.state.treeList.forEach((element) {
        ctx.state.cidList.add(element.id);
        ctx.state.datas.putIfAbsent(element.id, () => TabBarViewData());
      });
      ctx.state.tabViewStateModel.setSuccess();
      ctx.dispatch(TabProjectActionCreator.onReduceLoadTabData());
      ctx.dispatch(TabProjectActionCreator.onEffectRefresh(0));
    } else {
      ctx.state.tabViewStateModel.setError();
      ctx.dispatch(TabProjectActionCreator.onReduceLoadTabData());
    }
  });
}

/// dispose
void _onDispose(Action action, Context<TabProjectState> ctx) {
  ctx.state.tabController.dispose();
}

/// 下拉刷新
void _onRefresh(Action action, Context<TabProjectState> ctx) {
  ctx.state.tabIndex = action.payload;
  int cid = ctx.state.cidList[action.payload];
  TabBarViewData data = ctx.state.datas[cid];
  data.pageNum = TabBarViewData.pageNumFirst;
  data.setLoad();
  WanandroidApiHelper.fetchArticles(data.pageNum, cid: cid).then((response) {
    if (response.code == WanandroidResponse.SUCCESS_CODE) {
      var result = response.data['datas']
          .map<Article>((item) => Article.fromMap(item))
          .toList();
      if (result.isEmpty) {
        data.setEmpty();
      } else {
        data.articles = result;
        data.setSuccess();
      }
      ctx.dispatch(TabProjectActionCreator.onReducerRefresh());
    } else {
      data.setError();
      ctx.dispatch(TabProjectActionCreator.onReducerRefresh());
    }
  });
}

/// 上拉加载更多数据
void _onLoad(Action action, Context<TabProjectState> ctx) {
  int index = action.payload;
  ctx.state.tabIndex = index;
  int cid = ctx.state.cidList[index];
  TabBarViewData data = ctx.state.datas[cid];
  data.pageNum += 1;
  data.setLoad();
  WanandroidApiHelper.fetchArticles(data.pageNum, cid: cid).then((response) {
    if (response.code == WanandroidResponse.SUCCESS_CODE) {
      var result = response.data['datas']
          .map<Article>((item) => Article.fromMap(item))
          .toList();
      data.articles.addAll(result);
      data.setSuccess();
      ctx.dispatch(TabProjectActionCreator.onReducerLoad());
    } else {
      data.setError();
      ctx.dispatch(TabProjectActionCreator.onReducerLoad());
    }
  });
}

/// 打开webview查看详情
void _onOpenWebviewPage(Action action, Context<TabProjectState> ctx) {
  Navigator.pushNamed(ctx.context, RouteManager.webViewPage,
      arguments: action.payload);
}
