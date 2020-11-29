import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_starter/route/route.dart';
import 'action.dart';
import 'state.dart';

/// @Author: smarthane
/// @GitHub: https://github.com/smarthane
/// @Description:
/// @Date: 2020/11/29

Effect<LoginState> buildEffect() {
  return combineEffects(<Object, Effect<LoginState>>{
    Lifecycle.initState: _onInitState,
    Lifecycle.dispose: _onDispose,
    LoginAction.DO_LOGIN: _onDoLogin,
    LoginAction.START_REGISTER_PAGE: _onStartRegisterPage,
  });
}

/// 初始化
_onInitState(Action action, Context<LoginState> ctx) {}

/// dispose
_onDispose(Action action, Context<LoginState> ctx) {
  ctx.state.nameController.dispose();
  ctx.state.passwordController.dispose();
}

/// 执行登录逻辑
void _onDoLogin(Action action, Context<LoginState> ctx) {}

/// 打开注册页面
void _onStartRegisterPage(Action action, Context<LoginState> ctx) {
  Navigator.pushNamed(ctx.context, RouteManager.registerPage);
}
