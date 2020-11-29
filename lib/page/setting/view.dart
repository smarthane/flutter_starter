import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart' hide Action;
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_starter/generated/l10n.dart';

import 'action.dart';
import 'state.dart';

/// @Author: smarthane
/// @GitHub: https://github.com/smarthane
/// @Description:
/// @Date: 2020/11/29

Widget buildView(
    SettingState state, Dispatch dispatch, ViewService viewService) {
  var accentColor = state.store.themeModel.themeData.accentColor;
  var primaryColor = state.store.themeModel.themeData.primaryColor;
  return Scaffold(
    appBar: AppBar(
      title: Text(S.of(viewService.context).appSetting),
    ),
    body: SingleChildScrollView(
      child: ListTileTheme(
        contentPadding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Material(
              color: state.store.themeModel.themeData.cardColor,
              child: ListTile(
                title: Text('WebViewPlugin'),
                onTap: () {
                  dispatch(SettingActionCreator.onSwitchWebviewMode());
                },
                leading: Icon(
                  Icons.language,
                  color: accentColor,
                ),
                trailing: CupertinoSwitch(
                    activeColor: accentColor,
                    value: state.useWebViewPlugin,
                    onChanged: (value) {
                      dispatch(SettingActionCreator.onSwitchWebviewMode());
                    }),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Material(
              color: state.store.themeModel.themeData.cardColor,
              child: ListTile(
                title: Text(S.of(viewService.context).rate),
                onTap: () {},
                leading: Icon(
                  Icons.star,
                  color: accentColor,
                ),
                trailing: Icon(Icons.chevron_right),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Material(
              color: state.store.themeModel.themeData.cardColor,
              child: ListTile(
                title: Text(S.of(viewService.context).feedback),
                onTap: () {},
                leading: Icon(
                  Icons.feedback,
                  color: accentColor,
                ),
                trailing: Icon(Icons.chevron_right),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}