import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'state.dart';
import 'reducer.dart';

/// @Author: smarthane
/// @GitHub: https://github.com/smarthane
/// @Description:
/// @Date: 2020/11/29

/// 建立一个GlobalStore
/// 全局管理应用的store
class GlobalStore {
  static Store<GlobalState> _globalStore;

  static Store<GlobalState> get store =>
      _globalStore ??= createStore<GlobalState>(initState(), buildReducer());
}

/// 为了支持component可以拿到全局的 GlobalStore
/// https://github.com/alibaba/fish-redux/issues/596
class IGlobalStore extends InheritedWidget {
  IGlobalStore({@required this.globalState, Widget child})
      : super(child: child);
  final GlobalState globalState;

  static IGlobalStore of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<IGlobalStore>();
  }

  @override
  bool updateShouldNotify(IGlobalStore oldWidget) {
    return true;
  }

  /// 获取主题
  static ThemeData ofThemeData(BuildContext context) {
    return IGlobalStore.of(context).globalState.store.themeModel.themeData;
  }
}
