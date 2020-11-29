import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

/// @Author: smarthane
/// @GitHub: https://github.com/smarthane
/// @Description:
/// @Date: 2020/11/29

Effect<DemosState> buildEffect() {
  return combineEffects(<Object, Effect<DemosState>>{
    DemosAction.action: _onAction,
  });
}

void _onAction(Action action, Context<DemosState> ctx) {
}
