import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_starter/global_store/state.dart';

/// @Author: smarthane
/// @GitHub: https://github.com/smarthane
/// @Description:
/// @Date: 2020/11/29

class RegisterState implements Cloneable<RegisterState>, GlobalBaseState {
  TextEditingController nameController;
  TextEditingController passwordController;
  TextEditingController rePasswordController;

  @override
  RegisterState clone() {
    return RegisterState()
      ..store = store
      ..nameController = nameController
      ..passwordController = passwordController
      ..rePasswordController = rePasswordController;
  }

  @override
  StoreModel store;
}

RegisterState initState(Map<String, dynamic> args) {
  return RegisterState()
    ..nameController = TextEditingController()
    ..passwordController = TextEditingController()
    ..rePasswordController = TextEditingController();
}
