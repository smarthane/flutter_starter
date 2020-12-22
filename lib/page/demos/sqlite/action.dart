import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum SqliteAction { action }

class SqliteActionCreator {
  static Action onAction(int index) {
    return Action(SqliteAction.action, payload: index);
  }
}
