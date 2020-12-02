import 'dart:ui';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart' hide Action;
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_starter/api/model/user_model.dart';
import 'package:flutter_starter/common/app_manager.dart';
import 'package:flutter_starter/common/storage_manager.dart';

/// @Author: smarthane
/// @GitHub: https://github.com/smarthane
/// @Description:
/// @Date: 2020/11/29

abstract class GlobalBaseState {
  StoreModel store;
}

class GlobalState implements GlobalBaseState, Cloneable<GlobalState> {
  @override
  GlobalState clone() {
    return GlobalState()..store = store;
  }

  @override
  StoreModel store;
}

GlobalState initState() {
  final _themeModel = new GlobalThemeModel();
  final _localeModel = new GlobalLocaleModel();
  final _userModel = new GlobalUserModel();
  final _storeModel = new StoreModel(

      /// store这个变量,在这必须示例化,不然引用该变量中的字段,会报空指针
      /// 下面的字段,赋初值,就是初始时展示的全局状态
      /// 这地方初值,理应从缓存或数据库中取,表明用户选择的全局状态
      themeModel: _themeModel,
      localeModel: _localeModel,
      userModel: _userModel);
  return GlobalState()..store = _storeModel;
}

///全局实体
///需要增加字段就在这个实体里面添加就行了
class StoreModel {
  /// 主题包括 颜色 字体 黑夜模式
  GlobalThemeModel themeModel;

  /// 国际化i18n
  GlobalLocaleModel localeModel;

  /// 用户全局信息
  GlobalUserModel userModel;

  StoreModel({this.themeModel, this.localeModel, this.userModel});
}

/// 全局语言环境实体
class GlobalLocaleModel {
  int localeIndex;

  GlobalLocaleModel() {
    localeIndex = StorageManager.sharedPreferences
            .getInt(Constants.KEY_THEME_LOCALE_INDEX) ??
        0;
  }

  Locale get locale {
    if (localeIndex > 0) {
      var value = Constants.localeValueList[localeIndex].split("-");
      return Locale(value[0], value.length == 2 ? value[1] : '');
    }

    /// 跟随系统 目前默认用中文吧 TODO
    return Locale("zh", "CN");
  }
}

/// 全局主题实体
class GlobalThemeModel {
  /// 用户选择的明暗模式
  bool darkMode;

  /// 当前主题颜色
  MaterialColor themeColor;

  /// 当前字体索引
  int fontIndex;

  /// 主题Data
  ThemeData themeData;

  GlobalThemeModel() {
    /// 用户选择的明暗模式
    darkMode = StorageManager.sharedPreferences
            .getBool(Constants.KEY_THEME_DARK_MODE) ??
        false;

    /// 获取主题色
    themeColor = Constants.colors[StorageManager.sharedPreferences
            .getInt(Constants.KEY_THEME_MATERIAL_COLOR) ??
        5];

    /// 获取字体
    fontIndex = StorageManager.sharedPreferences
            .getInt(Constants.KEY_THEME_FONT_INDEX) ??
        0;

    /// 主题Data
    themeData = generateThemeData();
  }

  /// 根据主题 明暗 和 颜色 生成对应的主题
  /// [dark]系统的Dark Mode
  ///
  /// 黑夜模式用 primaryColor
  /// 保留黑夜模式之前的颜色用 accentColor
  ThemeData generateThemeData({bool platformDarkMode: false}) {
    if (themeColor == Constants.WHITE) {
      return _handleWhiteTheme(platformDarkMode: platformDarkMode);
    } else if (themeColor == Constants.BLACK) {
      return _handleBlackTheme(platformDarkMode: platformDarkMode);
    } else {
      return _handleCommonTheme(platformDarkMode: platformDarkMode);
    }
  }

  /// 处理黑白色之外的material主题
  ThemeData _handleCommonTheme({bool platformDarkMode: false}) {
    var isDark = platformDarkMode || darkMode;
    Brightness brightness = isDark ? Brightness.dark : Brightness.light;

    var accentColor = isDark ? themeColor[700] : themeColor;

    var themeData = ThemeData(
        brightness: brightness,
        // 主题颜色属于亮色系还是属于暗色系(eg:dark时,AppBarTitle文字及状态栏文字的颜色为白色,反之为黑色)
        // 这里设置为dark目的是,不管App是明or暗,都将appBar的字体颜色的默认值设为白色.
        // 再AnnotatedRegion<SystemUiOverlayStyle>的方式,调整响应的状态栏颜色
        primaryColorBrightness: Brightness.dark,
        accentColorBrightness: Brightness.dark,
        primarySwatch: themeColor,
        accentColor: accentColor,
        fontFamily: Constants.fontValueList[fontIndex]);

    themeData = themeData.copyWith(
      brightness: brightness,
      accentColor: accentColor,
      cupertinoOverrideTheme: CupertinoThemeData(
        primaryColor: themeColor,
        brightness: brightness,
      ),
      appBarTheme: themeData.appBarTheme.copyWith(elevation: 0),
      splashColor: themeColor.withAlpha(50),
      hintColor: themeData.hintColor.withAlpha(90),
      errorColor: Colors.red,
      cursorColor: accentColor,
      textTheme: themeData.textTheme.copyWith(

          /// 解决中文hint不居中的问题
          /// https://github.com/flutter/flutter/issues/40248
          subhead: themeData.textTheme.subhead
              .copyWith(textBaseline: TextBaseline.alphabetic)),
      textSelectionColor: accentColor.withAlpha(60),
      textSelectionHandleColor: accentColor.withAlpha(60),
      toggleableActiveColor: accentColor,
      chipTheme: themeData.chipTheme.copyWith(
        pressElevation: 0,
        padding: EdgeInsets.symmetric(horizontal: 10),
        labelStyle: themeData.textTheme.caption,
        backgroundColor: themeData.chipTheme.backgroundColor.withOpacity(0.1),
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(fontSize: 14),
        errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(width: 0.5, color: themeData.errorColor)),
        focusedErrorBorder: UnderlineInputBorder(
            borderSide: BorderSide(width: 0.7, color: themeData.errorColor)),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(width: 0.5, color: themeData.primaryColor)),
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(width: 0.5, color: themeData.dividerColor)),
        border: UnderlineInputBorder(
            borderSide: BorderSide(width: 0.5, color: themeData.dividerColor)),
        disabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(width: 0.5, color: themeData.disabledColor)),
      ),
    );
    return themeData;
  }

  /// 专门处理白色主题
  ThemeData _handleWhiteTheme({bool platformDarkMode: false}) {
    var isDark = platformDarkMode || darkMode;
    Brightness brightness = isDark ? Brightness.dark : Brightness.light;
    var accentColor = isDark ? themeColor : Constants.BLACK[700];
    var themeData = ThemeData(
        brightness: brightness,
        primarySwatch: themeColor,
        accentColor: accentColor,
        fontFamily: Constants.fontValueList[fontIndex]);
    return themeData;
  }

  /// 专门处理黑色主题
  ThemeData _handleBlackTheme({bool platformDarkMode: false}) {
    var isDark = platformDarkMode || darkMode;
    Brightness brightness = isDark ? Brightness.dark : Brightness.light;
    var themeData = ThemeData(
        brightness: brightness,
        primarySwatch: themeColor,
        fontFamily: Constants.fontValueList[fontIndex]);
    return themeData;
  }
}

/// 全局用户信息实体
class GlobalUserModel {
  User user;

  GlobalUserModel() {
    var userMap = StorageManager.localStorage.getItem(Constants.KEY_USER_INFO);
    user = userMap != null ? User.fromJsonMap(userMap) : null;
  }
}
