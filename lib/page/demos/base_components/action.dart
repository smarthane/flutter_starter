import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum BaseComponentsAction { action }

class BaseComponentsActionCreator {
  static Action onAction() {
    return const Action(BaseComponentsAction.action);
  }
}
