import 'dart:math';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_starter/common/app_manager.dart';
import 'package:flutter_starter/common/storage_manager.dart';
import 'package:flutter_starter/generated/l10n.dart';
import 'package:flutter_starter/global_store/store.dart';

import 'action.dart';
import 'state.dart';

/// @Author: smarthane
/// @GitHub: https://github.com/smarthane
/// @Description:
/// @Date: 2020/11/29

Reducer<GlobalState> buildReducer() {
  return asReducer(
    <Object, Reducer<GlobalState>>{
      GlobalAction.SWITCH_THEME: _onSwitchTheme,
      GlobalAction.SWITCH_DARK_MODE: _onSwitchDarkMode,
      GlobalAction.SWITCH_FONT_FAMILY: _onSwitchFontFamily,
      GlobalAction.SWITCH_LOCALE: _onSwitchLocale,
      GlobalAction.UPDATE_USER_INFO: _onUpdateUserInfo,
    },
  );
}

GlobalState _onSwitchTheme(GlobalState state, Action action) {
  var index = 0;
  if (action.payload["themeColor"] == null) {
    index = new Random().nextInt(Constants.colors.length - 1);
  } else {
    index = Constants.colors.indexOf(action.payload["themeColor"]);
  }
  final GlobalState newState = state.clone();
  newState.store.themeModel.themeColor = Constants.colors[index];
  newState.store.themeModel.themeData =
      newState.store.themeModel.generateThemeData();
  IGlobalStore.of(action.payload["context"]).globalState.clone()
    ..store = newState.store;
  StorageManager.sharedPreferences
      .setInt(Constants.KEY_THEME_MATERIAL_COLOR, index);
  return newState;
}

GlobalState _onSwitchDarkMode(GlobalState state, Action action) {
  final GlobalState newState = state.clone();
  newState.store.themeModel.darkMode = action.payload["darkMode"];
  newState.store.themeModel.themeData =
      newState.store.themeModel.generateThemeData();
  IGlobalStore.of(action.payload["context"]).globalState.clone()
    ..store = newState.store;
  StorageManager.sharedPreferences
      .setBool(Constants.KEY_THEME_DARK_MODE, action.payload["darkMode"]);
  return newState;
}

GlobalState _onSwitchFontFamily(GlobalState state, Action action) {
  final GlobalState newState = state.clone();
  newState.store.themeModel.fontIndex = action.payload["index"];
  newState.store.themeModel.themeData =
      newState.store.themeModel.generateThemeData();
  IGlobalStore.of(action.payload["context"]).globalState.clone()
    ..store = newState.store;
  StorageManager.sharedPreferences
      .setInt(Constants.KEY_THEME_FONT_INDEX, action.payload["index"]);
  return newState;
}

GlobalState _onSwitchLocale(GlobalState state, Action action) {
  final GlobalState newState = state.clone();
  newState.store.localeModel.localeIndex = action.payload["index"];
  newState.store.themeModel.themeData =
      newState.store.themeModel.generateThemeData();
  IGlobalStore.of(action.payload["context"]).globalState.clone()
    ..store = newState.store;
  if (newState.store.localeModel.locale != null) {
    S.delegate.load(newState.store.localeModel.locale);
  }
  StorageManager.sharedPreferences
      .setInt(Constants.KEY_THEME_LOCALE_INDEX, action.payload["index"]);
  return newState;
}

GlobalState _onUpdateUserInfo(GlobalState state, Action action) {
  final GlobalState newState = state.clone();
  return newState;
}
