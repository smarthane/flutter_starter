import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum FeedbackAction { action }

class FeedbackActionCreator {
  static Action onAction() {
    return const Action(FeedbackAction.action);
  }
}
