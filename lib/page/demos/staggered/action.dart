import 'package:fish_redux/fish_redux.dart';

/// @Author: smarthane
/// @GitHub: https://github.com/smarthane
/// @Description:
/// @Date: 2020/11/29

enum StaggeredAction {
  REDUCER_ON_REFRESH,
  REDUCER_ON_LOAD,
}

class StaggeredActionCreator {
  static Action onReducerRefresh() {
    return const Action(StaggeredAction.REDUCER_ON_REFRESH);
  }

  static Action onReducerLoad() {
    return const Action(StaggeredAction.REDUCER_ON_LOAD);
  }
}
