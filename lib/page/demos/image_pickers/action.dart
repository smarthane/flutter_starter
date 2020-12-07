import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum ImagePickersAction { action }

class ImagePickersActionCreator {
  static Action onAction(int index) {
    return Action(ImagePickersAction.action, payload: index);
  }
}
