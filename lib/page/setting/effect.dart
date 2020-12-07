import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_starter/route/route.dart';
import 'action.dart';
import 'state.dart';

/// @Author: smarthane
/// @GitHub: https://github.com/smarthane
/// @Description:
/// @Date: 2020/11/29

Effect<SettingState> buildEffect() {
  return combineEffects(<Object, Effect<SettingState>>{
    SettingAction.OPEN_WEBVIEW_PAGE: _onOpenWebviewPage,
    SettingAction.OPEN_FEEDBACK_PAGE: _onOpenFeedbackPage,
    SettingAction.OPEN_ABOUTME_PAGE: _onOpenAboutMePage,
  });
}

void _onOpenWebviewPage(Action action, Context<SettingState> ctx) {
  Navigator.pushNamed(ctx.context, RouteManager.webViewPage,
      arguments: action.payload);
}

void _onOpenFeedbackPage(Action action, Context<SettingState> ctx) {
  Navigator.pushNamed(ctx.context, RouteManager.feedbackPage);
}

void _onOpenAboutMePage(Action action, Context<SettingState> ctx) {
  Navigator.pushNamed(ctx.context, RouteManager.aboutMePage);
}
