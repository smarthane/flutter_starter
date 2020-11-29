import 'package:fish_redux/fish_redux.dart';

/// @Author: smarthane
/// @GitHub: https://github.com/smarthane
/// @Description:
/// @Date: 2020/11/29

enum SplashAction { ACTION, COUNTDOWN }

class SplashActionCreator {
  static Action onAction() {
    return const Action(SplashAction.ACTION);
  }

  static Action onCountDown(int value) {
    return Action(SplashAction.COUNTDOWN, payload: value);
  }
}
