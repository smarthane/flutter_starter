import 'package:fish_redux/fish_redux.dart';

/// @Author: smarthane
/// @GitHub: https://github.com/smarthane
/// @Description:
/// @Date: 2020/11/29

enum RegisterAction {
  EFFECT_ON_REGISTER,
  REDUCER_ON_REGISTER,
}

class RegisterActionCreator {
  static Action onEffectRegister(
      String username, String password, String rePassword) {
    var payload = {
      "username": username,
      "password": password,
      "rePassword": rePassword
    };
    return Action(RegisterAction.EFFECT_ON_REGISTER, payload: payload);
  }

  static Action onReducerRegister() {
    return const Action(RegisterAction.REDUCER_ON_REGISTER);
  }
}
