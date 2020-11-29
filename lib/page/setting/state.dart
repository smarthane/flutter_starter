import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_starter/common/app_manager.dart';
import 'package:flutter_starter/common/storage_manager.dart';
import 'package:flutter_starter/global_store/state.dart';

/// @Author: smarthane
/// @GitHub: https://github.com/smarthane
/// @Description:
/// @Date: 2020/11/29

class SettingState implements Cloneable<SettingState>, GlobalBaseState {
  bool useWebViewPlugin;

  @override
  SettingState clone() {
    return SettingState()
      ..store = store
      ..useWebViewPlugin = useWebViewPlugin;
  }

  @override
  StoreModel store;
}

SettingState initState(Map<String, dynamic> args) {
  bool useWebViewPlugin = StorageManager.sharedPreferences
          .getBool(Constants.KEY_USE_WEBVIEW_PLUGIN) ??
      true;
  return SettingState()..useWebViewPlugin = useWebViewPlugin;
}
