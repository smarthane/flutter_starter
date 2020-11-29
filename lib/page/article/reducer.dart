import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

/// @Author: smarthane
/// @GitHub: https://github.com/smarthane
/// @Description:
/// @Date: 2020/11/29

Reducer<ArticleState> buildReducer() {
  return asReducer(
    <Object, Reducer<ArticleState>>{
      ArticleAction.RACTION_ON_REFRESH: _onRefresh,
      ArticleAction.RACTION_ON_LOAD: _onLoad,
    },
  );
}

ArticleState _onRefresh(ArticleState state, Action action) {
  _articleItemData(state, action).refreshController.refreshCompleted();
  final ArticleState newState = state.clone();
  return newState;
}

ArticleState _onLoad(ArticleState state, Action action) {
  _articleItemData(state, action).refreshController.loadComplete();
  final ArticleState newState = state.clone();
  return newState;
}

ArticleItemData _articleItemData(ArticleState state, Action action) {
  int id = state.idList[state.tabIndex];
  var data = state.datas[id];
  return data;
}