import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

/// @Author: smarthane
/// @GitHub: https://github.com/smarthane
/// @Description:
/// @Date: 2020/11/29

Reducer<TabHomeState> buildReducer() {
  return asReducer(
    <Object, Reducer<TabHomeState>>{
      TabHomeAction.REDUCER_ON_REFRESH: _onRefresh,
      TabHomeAction.REDUCER_ON_LOAD: _onLoad,
      TabHomeAction.SCROLL_TO_TOP: _onScrollToTop,
    },
  );
}

TabHomeState _onRefresh(TabHomeState state, Action action) {
  final TabHomeState newState = state.clone();
  newState.currentPageNum = TabHomeState.pageNumFirst;
  newState.refreshController.refreshCompleted();
  return newState;
}

TabHomeState _onLoad(TabHomeState state, Action action) {
  final TabHomeState newState = state.clone();
  newState.articles.addAll(action.payload);
  newState.refreshController.loadComplete();
  return newState;
}

TabHomeState _onScrollToTop(TabHomeState state, Action action) {
  final TabHomeState newState = state.clone();
  newState.showTopBtn = action.payload;
  return newState;
}
