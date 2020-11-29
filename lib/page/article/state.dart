import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_starter/api/model/article_model.dart';
import 'package:flutter_starter/api/model/tree_model.dart';
import 'package:flutter_starter/common/http_manager.dart';
import 'package:flutter_starter/global_store/state.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// @Author: smarthane
/// @GitHub: https://github.com/smarthane
/// @Description:
/// @Date: 2020/11/29

class ArticleState implements Cloneable<ArticleState>, GlobalBaseState {
  Tree tree;
  int tabIndex;
  TabController tabController;

  /// id -> data
  Map<int, ArticleItemData> datas;
  List<int> idList;

  @override
  ArticleState clone() {
    return ArticleState()
      ..tree = tree
      ..idList = idList
      ..tabIndex = tabIndex
      ..datas = datas
      ..tabController = tabController;
  }

  @override
  StoreModel store;
}

ArticleState initState(Map<String, dynamic> args) {
  return ArticleState()
    ..tree = args["tree"]
    ..tabIndex = args["index"]
    ..idList = []
    ..datas = Map.identity();
}

class ArticleItemData extends ViewStateModel
    implements Cloneable<ArticleItemData> {
  /// 分页第一页页码
  static const int pageNumFirst = 0;

  List<Article> articles = [];
  RefreshController refreshController =
      new RefreshController(initialRefresh: false);
  int pageNum = pageNumFirst;

  @override
  ArticleItemData clone() {
    return ArticleItemData()
      ..requestState = requestState
      ..articles = articles
      ..refreshController = refreshController
      ..pageNum = pageNum;
  }
}
