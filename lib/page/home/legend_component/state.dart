import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_starter/api/model/article_model.dart';
import 'package:flutter_starter/api/model/tree_model.dart';
import 'package:flutter_starter/common/http_manager.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// @Author: smarthane
/// @GitHub: https://github.com/smarthane
/// @Description:
/// @Date: 2020/11/29

class TabLegendState implements Cloneable<TabLegendState> {
  List<Tree> treeList;
  TabController tabController;
  int currentTabIndex;

  /// id -> data
  Map<int, TabBarViewItemData> datas;
  List<int> idList;

  @override
  TabLegendState clone() {
    return TabLegendState()
      ..datas = datas
      ..idList = idList
      ..treeList = treeList
      ..currentTabIndex = currentTabIndex
      ..tabController = tabController;
  }
}

TabLegendState initTabLegendState(Map<String, dynamic> args) {
  return TabLegendState()
    ..currentTabIndex = 0
    ..treeList = []
    ..idList = []
    ..datas = Map.identity();
}

class TabBarViewItemData extends ViewStateModel
    implements Cloneable<TabBarViewItemData> {
  /// 分页第一页页码
  static const int pageNumFirst = 0;

  List<Article> articles = [];
  RefreshController refreshController =
      new RefreshController(initialRefresh: false);
  int pageNum = pageNumFirst;

  @override
  TabBarViewItemData clone() {
    return TabBarViewItemData()
      ..requestState = requestState
      ..articles = articles
      ..refreshController = refreshController
      ..pageNum = pageNum;
  }
}
