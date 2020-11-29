import 'package:fish_redux/fish_redux.dart';

/// @Author: smarthane
/// @GitHub: https://github.com/smarthane
/// @Description:
/// @Date: 2020/11/29

enum LoginAction { DO_LOGIN, START_REGISTER_PAGE }

class LoginActionCreator {
  static Action onDoLogin() {
    return const Action(LoginAction.DO_LOGIN);
  }

  static Action onStartRegisterPage() {
    return const Action(LoginAction.START_REGISTER_PAGE);
  }
}
