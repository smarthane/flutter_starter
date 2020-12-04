import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum CityPickersAction { action }

class CityPickersActionCreator {
  static Action onAction(int index) {
    return Action(CityPickersAction.action, payload: index);
  }
}
