import 'dart:async';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'action.dart';
import 'state.dart';

/// @Author: smarthane
/// @GitHub: https://github.com/smarthane
/// @Description:
/// @Date: 2020/11/29

Effect<WebviewState> buildEffect() {
  return combineEffects(<Object, Effect<WebviewState>>{
    Lifecycle.initState: _onInitState,
    Lifecycle.dispose: _onDispose,
    WebviewAction.action: _onAction,
  });
}

void _onInitState(Action action, Context<WebviewState> ctx) {
  ctx.state.finishedCompleter = new Completer();
  if (ctx.state.useWebViewPlugin) {
    ctx.state.flutterWebviewPlugin = new FlutterWebviewPlugin();
    ctx.state.flutterWebviewPlugin.onStateChanged
        .listen((WebViewStateChanged webViewStateChanged) {
      if (!ctx.state.finishedCompleter.isCompleted &&
          webViewStateChanged.type == WebViewState.finishLoad) {
        ctx.state.finishedCompleter.complete(true);
      }
    });
  }
}

void _onDispose(Action action, Context<WebviewState> ctx) {
  if (ctx.state.useWebViewPlugin && ctx.state.flutterWebviewPlugin != null) {
    ctx.state.flutterWebviewPlugin.dispose();
  }
}

void _onAction(Action action, Context<WebviewState> ctx) {}
