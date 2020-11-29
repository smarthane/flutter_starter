import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_starter/global_store/state.dart';
import 'package:flutter_starter/page/home/home_component/state.dart';
import 'package:flutter_starter/page/home/legend_component/state.dart';
import 'package:flutter_starter/page/home/project_component/state.dart';
import 'package:flutter_starter/page/home/structure_component/state.dart';

/// @Author: smarthane
/// @GitHub: https://github.com/smarthane
/// @Description:
/// @Date: 2020/11/29

class HomeState implements Cloneable<HomeState>, GlobalBaseState {
  TabHomeState tabHomeState;
  TabProjectState tabProjectState;
  TabStructureState tabStructureState;
  TabLegendState tabLegendState;
  PageController tabPageController;
  List<Widget> tabPages;
  List<String> tabTitles;
  int tabSelectedIndex;

  DateTime lasPopTime;
  String androidExitAppTip;

  @override
  HomeState clone() {
    return HomeState()
      ..tabHomeState = tabHomeState
      ..tabProjectState = tabProjectState
      ..tabStructureState = tabStructureState
      ..tabLegendState = tabLegendState
      ..tabPageController = tabPageController
      ..tabPages = tabPages
      ..tabTitles = tabTitles
      ..tabSelectedIndex = tabSelectedIndex
      ..androidExitAppTip = androidExitAppTip
      ..lasPopTime = lasPopTime
      ..store = store;
  }

  @override
  StoreModel store;
}

HomeState initState(Map<String, dynamic> args) {
  return HomeState()
    ..androidExitAppTip = ""
    ..tabSelectedIndex = 0
    ..tabPageController = PageController()
    ..tabHomeState = initTabHomeState(null)
    ..tabProjectState = initTabProjectState(null)
    ..tabLegendState = initTabLegendState(null)
    ..tabStructureState = initTabStructureState(null);
}

/// 首页TAB连接器
class TabHomeConnector extends ConnOp<HomeState, TabHomeState> {
  @override
  TabHomeState get(HomeState state) {
    return state.tabHomeState;
  }

  @override
  void set(HomeState state, TabHomeState subState) {
    state.tabHomeState = subState;
  }
}

/// 项目TAB连接器
class TabProjectConnector extends ConnOp<HomeState, TabProjectState> {
  @override
  TabProjectState get(HomeState state) {
    return state.tabProjectState;
  }

  @override
  void set(HomeState state, TabProjectState subState) {
    state.tabProjectState = subState;
  }
}

/// 体系TAB连接器
class TabStructureConnector extends ConnOp<HomeState, TabStructureState> {
  @override
  TabStructureState get(HomeState state) {
    return state.tabStructureState;
  }

  @override
  void set(HomeState state, TabStructureState subState) {
    state.tabStructureState = subState;
  }
}

/// 大神TAB连接器
class TabLegendConnector extends ConnOp<HomeState, TabLegendState> {
  @override
  TabLegendState get(HomeState state) {
    return state.tabLegendState;
  }

  @override
  void set(HomeState state, TabLegendState subState) {
    state.tabLegendState = subState;
  }
}
