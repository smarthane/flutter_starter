import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

/// @Author: smarthane
/// @GitHub: https://github.com/smarthane
/// @Description:
/// @Date: 2020/11/29

Reducer<DemosState> buildReducer() {
  return asReducer(
    <Object, Reducer<DemosState>>{
      DemosAction.REDUCER_ON_REFRESH: _onRefresh,
      DemosAction.REDUCER_ON_LOAD: _onLoad,
    },
  );
}

DemosState _onRefresh(DemosState state, Action action) {
  state.refreshController.refreshCompleted();
  final DemosState newState = state.clone();
  return newState;
}

DemosState _onLoad(DemosState state, Action action) {
  state.refreshController.loadComplete();
  final DemosState newState = state.clone();
  return newState;
}