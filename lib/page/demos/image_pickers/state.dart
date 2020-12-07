import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_starter/global_store/state.dart';

class ImagePickersState implements Cloneable<ImagePickersState> , GlobalBaseState {

  List<String> itemList;

  @override
  ImagePickersState clone() {
    return ImagePickersState()
      ..store = store
      ..itemList = itemList;
  }

  @override
  StoreModel store;
}

ImagePickersState initState(Map<String, dynamic> args) {
  return ImagePickersState()
    ..itemList = ["1.选择图片", "2.选择视频", "3.拍照片", "4.拍视频", "5.预览图片"];
}
