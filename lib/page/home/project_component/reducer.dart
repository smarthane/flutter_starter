import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

/// @Author: smarthane
/// @GitHub: https://github.com/smarthane
/// @Description:
/// @Date: 2020/11/29

Reducer<TabProjectState> buildReducer() {
  return asReducer(
    <Object, Reducer<TabProjectState>>{
      TabProjectAction.REDUCER_ON_LOAD_TAB_DATA: _onTabDataAction,
      TabProjectAction.REDUCER_ON_REFRESH: _onRefresh,
      TabProjectAction.REDUCER_ON_LOAD: _onLoad,
    },
  );
}

TabProjectState _onTabDataAction(TabProjectState state, Action action) {
  final TabProjectState newState = state.clone();
  return newState;
}

TabProjectState _onRefresh(TabProjectState state, Action action) {
  _tabBarViewData(state, action).refreshController.refreshCompleted();
  final TabProjectState newState = state.clone();
  return newState;
}

TabProjectState _onLoad(TabProjectState state, Action action) {
  _tabBarViewData(state, action).refreshController.loadComplete();
  final TabProjectState newState = state.clone();
  return newState;
}

TabBarViewData _tabBarViewData(TabProjectState state, Action action) {
  int cid = state.cidList[state.tabIndex];
  var data = state.datas[cid];
  return data;
}
