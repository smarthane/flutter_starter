import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

/// @Author: smarthane
/// @GitHub: https://github.com/smarthane
/// @Description:
/// @Date: 2020/11/29

Reducer<LoginState> buildReducer() {
  return asReducer(
    <Object, Reducer<LoginState>>{
      LoginAction.REDUCER_ON_LOGIN: _onLogin,
    },
  );
}

LoginState _onLogin(LoginState state, Action action) {
  final LoginState newState = state.clone();
  return newState;
}
