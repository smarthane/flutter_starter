import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

/// @Author: smarthane
/// @GitHub: https://github.com/smarthane
/// @Description:
/// @Date: 2020/11/29

Reducer<TabStructureState> buildReducer() {
  return asReducer(
    <Object, Reducer<TabStructureState>>{
      TabStructureAction.R_ACTION_LOAD_STRUCTURE_CATEGORY: _onLoadStructureCategory,
      TabStructureAction.R_ACTION_LOAD_NAVIGATION_SITE_CATEGORY: _onLoadNavigationSiteCategory,
    },
  );
}

TabStructureState _onLoadStructureCategory(TabStructureState state, Action action) {
  final TabStructureState newState = state.clone();
  return newState;
}

TabStructureState _onLoadNavigationSiteCategory(TabStructureState state, Action action) {
  final TabStructureState newState = state.clone();
  return newState;
}