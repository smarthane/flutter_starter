import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_starter/api/model/user_model.dart';
import 'package:flutter_starter/api/wanandroid_api_helper.dart';
import 'package:flutter_starter/common/app_manager.dart';
import 'package:flutter_starter/common/storage_manager.dart';
import 'package:flutter_starter/global_store/action.dart';
import 'package:flutter_starter/global_store/store.dart';
import 'package:flutter_starter/route/route.dart';
import 'package:flutter_starter/util/toast_utils.dart';
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
    LoginAction.EFFECT_ON_LOGIN: _onLogin,
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
void _onLogin(Action action, Context<LoginState> ctx) {
  var username = action.payload["username"];
  var password = action.payload["password"];
  ctx.state.viewStateModel.setLoad();
  ctx.dispatch(LoginActionCreator.onReducerLogin());
  WanandroidApiHelper.login(username, password)
      .then((response) {
    if (response.code == WanandroidResponse.SUCCESS_CODE) {
      var user = User.fromJsonMap(response.data);
      ctx.state.viewStateModel.setSuccess();
      ctx.state.store.userModel.user = user;
      StorageManager.localStorage.setItem(Constants.KEY_USER_INFO, user);
      ToastUtils.showText("恭喜，登录成功！");
      GlobalStore.store.dispatch(GlobalActionCreator.onUpdateUserInfo(true));
      Navigator.of(ctx.context).pop(true);
    } else {
      ToastUtils.showText(response.message);
      ctx.state.viewStateModel.setError();
      ctx.dispatch(LoginActionCreator.onReducerLogin());
    }
  });
}

/// 打开注册页面
void _onStartRegisterPage(Action action, Context<LoginState> ctx) {
  Navigator.pushNamed(ctx.context, RouteManager.registerPage);
}
