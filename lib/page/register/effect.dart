import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

/// @Author: smarthane
/// @GitHub: https://github.com/smarthane
/// @Description:
/// @Date: 2020/11/29

Effect<RegisterState> buildEffect() {
  return combineEffects(<Object, Effect<RegisterState>>{
    Lifecycle.initState: _onInitState,
    Lifecycle.dispose: _onDispose,
    RegisterAction.action: _onAction,
  });
}

/// 初始化
_onInitState(Action action, Context<RegisterState> ctx) {}

/// dispose
_onDispose(Action action, Context<RegisterState> ctx) {
  ctx.state.nameController.dispose();
  ctx.state.passwordController.dispose();
  ctx.state.rePasswordController.dispose();
}

void _onAction(Action action, Context<RegisterState> ctx) {}
