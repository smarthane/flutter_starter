import 'package:fish_redux/fish_redux.dart';

/// @Author: smarthane
/// @GitHub: https://github.com/smarthane
/// @Description:
/// @Date: 2020/11/29

enum LoginAction { EFFECT_ON_LOGIN, REDUCER_ON_LOGIN, START_REGISTER_PAGE }

class LoginActionCreator {
  static Action onEffectLogin(String username, String password) {
    var payload = {"username": username, "password": password};
    return Action(LoginAction.EFFECT_ON_LOGIN, payload: payload);
  }

  static Action onReducerLogin() {
    return const Action(LoginAction.REDUCER_ON_LOGIN);
  }

  static Action onStartRegisterPage() {
    return const Action(LoginAction.START_REGISTER_PAGE);
  }
}
