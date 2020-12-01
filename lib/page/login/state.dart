import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_starter/common/http_manager.dart';
import 'package:flutter_starter/global_store/state.dart';

/// @Author: smarthane
/// @GitHub: https://github.com/smarthane
/// @Description:
/// @Date: 2020/11/29

class LoginState implements Cloneable<LoginState>, GlobalBaseState {

  ViewStateModel viewStateModel;

  TextEditingController nameController;
  TextEditingController passwordController;
  FocusNode pwdFocus;

  @override
  LoginState clone() {
    return LoginState()
      ..store = store
      ..nameController = nameController
      ..passwordController = passwordController
      ..pwdFocus = pwdFocus
      ..viewStateModel = viewStateModel;
  }

  @override
  StoreModel store;
}

LoginState initState(Map<String, dynamic> args) {
  return LoginState()
    ..pwdFocus = FocusNode()
    ..passwordController = TextEditingController()
    ..nameController = TextEditingController()
    ..viewStateModel = ViewStateModel();
}
