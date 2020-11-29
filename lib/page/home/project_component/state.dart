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

class TabProjectState implements Cloneable<TabProjectState> {
  List<Tree> treeList;
  TabController tabController;
  int tabIndex;

  /// cid -> data
  Map<int, TabBarViewData> datas;
  List<int> cidList;

  @override
  TabProjectState clone() {
    return TabProjectState()
      ..treeList = treeList
      ..cidList = cidList
      ..tabIndex = tabIndex
      ..datas = datas
      ..tabController = tabController;
  }
}

TabProjectState initTabProjectState(Map<String, dynamic> args) {
  return TabProjectState()
    ..tabIndex = 0
    ..treeList = []
    ..cidList = []
    ..datas = Map.identity();
}

class TabBarViewData extends ViewStateModel
    implements Cloneable<TabBarViewData> {
  /// 分页第一页页码
  static const int pageNumFirst = 0;

  List<Article> articles = [];
  RefreshController refreshController =
      new RefreshController(initialRefresh: false);
  int pageNum = pageNumFirst;

  @override
  TabBarViewData clone() {
    return TabBarViewData()
      ..requestState = requestState
      ..articles = articles
      ..refreshController = refreshController
      ..pageNum = pageNum;
  }
}
