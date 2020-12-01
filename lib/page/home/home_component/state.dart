import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action, Banner;
import 'package:flutter_starter/api/model/article_model.dart';
import 'package:flutter_starter/api/model/banner_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_starter/common/http_manager.dart';

/// @Author: smarthane
/// @GitHub: https://github.com/smarthane
/// @Description:
/// @Date: 2020/11/29

class TabHomeState implements Cloneable<TabHomeState> {

  ViewStateModel tabViewStateModel;

  /// 分页第一页页码
  static const int pageNumFirst = 0;
  static const int tapToTopLimitHeight = 200;

  /// 当前页码
  int currentPageNum = pageNumFirst;

  /// Banner数据
  List<Banner> banners;

  /// Articles数据
  List<Article> articles;

  RefreshController refreshController;
  ScrollController scrollController;

  /// 是否显示悬浮回到顶部的按钮
  bool showTopBtn;

  @override
  TabHomeState clone() {
    return TabHomeState()
      ..showTopBtn = showTopBtn
      ..banners = banners
      ..articles = articles
      ..currentPageNum = currentPageNum
      ..refreshController = refreshController
      ..scrollController = scrollController
      ..tabViewStateModel = tabViewStateModel;
  }
}

TabHomeState initTabHomeState(Map<String, dynamic> args) {
  return TabHomeState()
    ..showTopBtn = false
    ..banners = []
    ..articles = []
    ..refreshController = new RefreshController(initialRefresh: false)
    ..tabViewStateModel = ViewStateModel(requestState: RequestState.load);
}
