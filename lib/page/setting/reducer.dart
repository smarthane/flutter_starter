import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_starter/common/app_manager.dart';
import 'package:flutter_starter/common/storage_manager.dart';

import 'action.dart';
import 'state.dart';

/// @Author: smarthane
/// @GitHub: https://github.com/smarthane
/// @Description:
/// @Date: 2020/11/29

Reducer<SettingState> buildReducer() {
  return asReducer(
    <Object, Reducer<SettingState>>{
      SettingAction.SWITCH_WEBVIEW_MODE: _onSwitchWebviewMode,
      SettingAction.action: _onAction,
    },
  );
}

SettingState _onSwitchWebviewMode(SettingState state, Action action) {
  final SettingState newState = state.clone();
  newState.useWebViewPlugin = !newState.useWebViewPlugin;
  StorageManager.sharedPreferences
      .setBool(Constants.KEY_USE_WEBVIEW_PLUGIN, newState.useWebViewPlugin);
  return newState;
}

SettingState _onAction(SettingState state, Action action) {
  final SettingState newState = state.clone();
  return newState;
}
