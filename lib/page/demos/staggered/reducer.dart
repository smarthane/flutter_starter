import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

/// @Author: smarthane
/// @GitHub: https://github.com/smarthane
/// @Description:
/// @Date: 2020/11/29

Reducer<StaggeredState> buildReducer() {
  return asReducer(
    <Object, Reducer<StaggeredState>>{
      StaggeredAction.REDUCER_ON_REFRESH: _onRefresh,
      StaggeredAction.REDUCER_ON_LOAD: _onLoad,
    },
  );
}

StaggeredState _onRefresh(StaggeredState state, Action action) {
  state.refreshController.refreshCompleted();
  final StaggeredState newState = state.clone();
  return newState;
}

StaggeredState _onLoad(StaggeredState state, Action action) {
  state.refreshController.loadComplete();
  final StaggeredState newState = state.clone();
  return newState;
}
