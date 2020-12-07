import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum AboutMeAction { action }

class AboutMeActionCreator {
  static Action onAction() {
    return const Action(AboutMeAction.action);
  }
}
