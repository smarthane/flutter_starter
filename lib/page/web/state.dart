import 'dart:async';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_starter/common/app_manager.dart';
import 'package:flutter_starter/common/storage_manager.dart';
import 'package:flutter_starter/global_store/state.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// @Author: smarthane
/// @GitHub: https://github.com/smarthane
/// @Description:
/// @Date: 2020/11/29

class WebviewState implements Cloneable<WebviewState>, GlobalBaseState {
  bool useWebViewPlugin;

  String url;
  String title;

  WebViewController webViewController;
  Completer<bool> finishedCompleter;

  FlutterWebviewPlugin flutterWebviewPlugin;

  @override
  WebviewState clone() {
    return WebviewState()
      ..useWebViewPlugin = useWebViewPlugin
      ..url = url
      ..title = title
      ..finishedCompleter = finishedCompleter
      ..webViewController = webViewController
      ..flutterWebviewPlugin = flutterWebviewPlugin
      ..store = store;
  }

  @override
  StoreModel store;
}

WebviewState initState(Map<String, dynamic> args) {
  bool useWebViewPlugin = StorageManager.sharedPreferences
          .getBool(Constants.KEY_USE_WEBVIEW_PLUGIN) ??
      true;
  var state = WebviewState();
  state.useWebViewPlugin = useWebViewPlugin;
  state.title = args["title"];
  state.url = args["url"];
  return state;
}
