import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/services.dart';
import 'package:flutter_starter/util/toast_utils.dart';

import 'action.dart';
import 'state.dart';

/// @Author: smarthane
/// @GitHub: https://github.com/smarthane
/// @Description:
/// @Date: 2020/11/29

Reducer<HomeState> buildReducer() {
  return asReducer(
    <Object, Reducer<HomeState>>{
      HomeAction.ANDROID_EXIT_APP: _onAndroidExitApp,
      HomeAction.JUMP_TAB_PAGE: _jumpTabPage,
    },
  );
}

///首页 TAB 页面切换
HomeState _jumpTabPage(HomeState state, Action action) {
  final HomeState newState = state.clone();
  newState.tabSelectedIndex = action.payload;
  return newState;
}

HomeState _onAndroidExitApp(HomeState state, Action action) {
  final HomeState newState = state.clone();
  if (newState.lasPopTime == null ||
      DateTime.now().difference(newState.lasPopTime) >
          Duration(milliseconds: 1500)) {
    ToastUtils.showText(state.androidExitAppTip);
  } else {
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  }
  newState.lasPopTime = DateTime.now();
  return newState;
}
