import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

/// @Author: smarthane
/// @GitHub: https://github.com/smarthane
/// @Description:
/// @Date: 2020/11/29

Reducer<TabLegendState> buildReducer() {
  return asReducer(
    <Object, Reducer<TabLegendState>>{
      TabLegendAction.ACTION_TAB_DATA: _onTabDataAction,
      TabLegendAction.REDUCER_ON_REFRESH: _onRefresh,
      TabLegendAction.REDUCER_ON_LOAD: _onLoad,
    },
  );
}

TabLegendState _onTabDataAction(TabLegendState state, Action action) {
  final TabLegendState newState = state.clone();
  return newState;
}

TabLegendState _onRefresh(TabLegendState state, Action action) {
  _tabBarViewItemData(state, action).refreshController.refreshCompleted();
  final TabLegendState newState = state.clone();
  return newState;
}

TabLegendState _onLoad(TabLegendState state, Action action) {
  _tabBarViewItemData(state, action).refreshController.loadComplete();
  final TabLegendState newState = state.clone();
  return newState;
}

TabBarViewItemData _tabBarViewItemData(TabLegendState state, Action action) {
  int cid = state.idList[state.currentTabIndex];
  var data = state.datas[cid];
  return data;
}
