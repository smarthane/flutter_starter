import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'action.dart';
import 'state.dart';

/// @Author: smarthane
/// @GitHub: https://github.com/smarthane
/// @Description:
/// @Date: 2020/11/29
///
///
/// 详细用法 参考
/// https://github.com/MMMzq/bot_toast/blob/master/API.md
///
/// 调用BotToast.showXxx都会返回一个CancelFunc函数,调用此函数将会提前关闭对应的Toast
///
///

Widget buildView(
    BotToastState state, Dispatch dispatch, ViewService viewService) {
  var themeData = state.store.themeModel.themeData;
  return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Bot Toast"),
      ),
      body: ListView.builder(
          itemCount: state.itemList.length,
          itemBuilder: (context, index) {
            return Builder(builder: (context) {
              state.targetContext = context;
              return new Card(
                  child: new InkWell(
                onTap: () {
                  dispatch(BotToastActionCreator.onAction(index));
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Center(
                    child: Text(
                      state.itemList[index],
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ));
            });
          }));
}
