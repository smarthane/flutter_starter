import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_starter/api/model/navigation_site_model.dart';
import 'package:flutter_starter/api/model/tree_model.dart';

/// @Author: smarthane
/// @GitHub: https://github.com/smarthane
/// @Description:
/// @Date: 2020/11/29

class TabStructureState implements Cloneable<TabStructureState> {
  List<String> tabs;
  TabController tabController;
  int currentTabIndex;

  List<Tree> treeList;
  List<NavigationSite> navigationSiteList;

  @override
  TabStructureState clone() {
    return TabStructureState()
      ..tabs = tabs
      ..treeList = treeList
      ..navigationSiteList = navigationSiteList
      ..currentTabIndex = currentTabIndex
      ..tabController = tabController;
  }
}

TabStructureState initTabStructureState(Map<String, dynamic> args) {
  return TabStructureState()
    ..tabs = ['体系', '导航']
    ..treeList = []
    ..navigationSiteList = []
    ..currentTabIndex = 0;
}
