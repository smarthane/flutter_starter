import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_starter/api/wanandroid_api_helper.dart';
import 'package:flutter_starter/util/toast_utils.dart';

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
    RegisterAction.EFFECT_ON_REGISTER: _onRegister,
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

void _onRegister(Action action, Context<RegisterState> ctx) {
  var username = action.payload["username"];
  var password = action.payload["password"];
  var rePassword = action.payload["rePassword"];
  ctx.state.viewStateModel.setLoad();
  ctx.dispatch(RegisterActionCreator.onReducerRegister());
  WanandroidApiHelper.register(username, password, rePassword)
      .then((response) {
    if (response.code == WanandroidResponse.SUCCESS_CODE) {
      ctx.state.viewStateModel.setSuccess();
      ToastUtils.showText("恭喜，注册成功！");
      Navigator.of(ctx.context).pop(true);
    } else {
      ToastUtils.showText(response.message);
      ctx.state.viewStateModel.setError();
      ctx.dispatch(RegisterActionCreator.onReducerRegister());
    }
  });
}
