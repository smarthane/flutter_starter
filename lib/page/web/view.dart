import 'dart:async';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_starter/generated/l10n.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'state.dart';

/// @Author: smarthane
/// @GitHub: https://github.com/smarthane
/// @Description:
/// @Date: 2020/11/29

Widget buildView(
    WebviewState state, Dispatch dispatch, ViewService viewService) {
  return state.useWebViewPlugin
      ? _buildWebViewPlugin(state, dispatch, viewService)
      : _buildWebView(state, dispatch, viewService);
}

/// webview_flutter 官方 webview
Widget _buildWebView(
    WebviewState state, Dispatch dispatch, ViewService viewService) {
  var themeData = state.store.themeModel.themeData;
  return Scaffold(
    appBar: AppBar(
      centerTitle: true,
      title: Row(
        children: <Widget>[
          FutureBuilder<bool>(
            future: state.finishedCompleter.future,
            initialData: false,
            builder: (context, snapshot) => snapshot.data
                ? SizedBox.shrink()
                : Padding(
                    padding: EdgeInsets.only(right: 5),
                    child: Theme(
                        data: ThemeData(
                            cupertinoOverrideTheme: CupertinoThemeData(
                                brightness: Brightness.dark)),
                        child: CupertinoActivityIndicator(radius: 10))),
          ),
          Expanded(
              child: Text(
            state.title,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 16),
          ))
        ],
      ),
      actions: <Widget>[
        IconButton(
          tooltip: S.of(viewService.context).openBrowser,
          icon: Icon(Icons.language),
          onPressed: () {
            launch(state.url, forceSafariVC: false);
          },
        ),
      ],
    ),
    body: Builder(
      builder: (BuildContext context) {
        return MediaQuery.removePadding(
            context: viewService.context,
            child: SafeArea(
                top: false,
                bottom: false,
                child: MediaQuery.removePadding(
                  context: viewService.context,
                  child: WebView(
                    // 初始化加载的url
                    initialUrl: state.url,
                    // 加载js
                    javascriptMode: JavascriptMode.unrestricted,
                    navigationDelegate: (NavigationRequest request) {
                      ///TODO isForMainFrame为false,页面不跳转.导致网页内很多链接点击没效果
                      if (!request.url.startsWith('http')) {
                        ///TODO 处理其它请求
                        _filterRequest(
                            state, dispatch, viewService, request.url);
                        return NavigationDecision.prevent;
                      } else {
                        return NavigationDecision.navigate;
                      }
                    },
                    onWebViewCreated: (WebViewController controller) {
                      state.webViewController = controller;
                    },
                    onPageFinished: (String value) async {
                      if (!state.finishedCompleter.isCompleted) {
                        state.finishedCompleter.complete(true);
                      }
                    },
                  ),
                )));
      },
    ),
    bottomNavigationBar: BottomAppBar(
      child: IconTheme(
        data: themeData.iconTheme.copyWith(opacity: 0.7),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  state.webViewController.goBack();
                }),
            IconButton(
                icon: Icon(Icons.arrow_forward_ios),
                onPressed: () {
                  state.webViewController.goForward();
                }),
            IconButton(
              tooltip: S.of(viewService.context).refresh,
              icon: const Icon(Icons.autorenew),
              onPressed: () {
                state.webViewController.reload();
              },
            ),
          ],
        ),
      ),
    ),
  );
}

/// flutter_webview_plugin 三方webview插件
/// https://github.com/fluttercommunity/flutter_webview_plugin
Widget _buildWebViewPlugin(
    WebviewState state, Dispatch dispatch, ViewService viewService) {
  var themeData = state.store.themeModel.themeData;
  return WebviewScaffold(
    url: state.url,
    withJavascript: true,
    displayZoomControls: true,
    withZoom: true,
    appBar: AppBar(
      centerTitle: true,
      title: Row(
        children: <Widget>[
          FutureBuilder<bool>(
            future: state.finishedCompleter.future,
            initialData: false,
            builder: (context, snapshot) => snapshot.data
                ? SizedBox.shrink()
                : Padding(
                    padding: EdgeInsets.only(right: 5),
                    child: Theme(
                        data: ThemeData(
                            cupertinoOverrideTheme: CupertinoThemeData(
                                brightness: Brightness.dark)),
                        child: CupertinoActivityIndicator(radius: 10))),
          ),
          Expanded(
              child: Text(
            state.title,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 16),
          ))
        ],
      ),
      actions: <Widget>[
        IconButton(
          tooltip: S.of(viewService.context).openBrowser,
          icon: Icon(Icons.language),
          onPressed: () {
            launch(state.url, forceSafariVC: false);
          },
        ),
      ],
    ),
    bottomNavigationBar: BottomAppBar(
      child: IconTheme(
        data: themeData.iconTheme.copyWith(opacity: 0.7),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  state.flutterWebviewPlugin.goBack();
                }),
            IconButton(
                icon: Icon(Icons.arrow_forward_ios),
                onPressed: () {
                  state.flutterWebviewPlugin.goForward();
                }),
            IconButton(
              tooltip: S.of(viewService.context).refresh,
              icon: const Icon(Icons.autorenew),
              onPressed: () {
                state.flutterWebviewPlugin.reload();
              },
            ),
          ],
        ),
      ),
    ),
  );
}

/// 如果我们页面需要调起微信和支付宝支付，我们可以通过拦截的形式来处理。
void _filterRequest(WebviewState state, Dispatch dispatch,
    ViewService viewService, String url) {}
