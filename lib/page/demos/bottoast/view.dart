import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'action.dart';
import 'state.dart';

/// @Author: smarthane
/// @GitHub: https://github.com/smarthane
/// @Description:
/// @Date: 2020/11/29

Widget buildView(
    BotToastState state, Dispatch dispatch, ViewService viewService) {
  var themeData = state.store.themeModel.themeData;
  return Scaffold(
      appBar: AppBar(
        title: Text("Bot Toast"),
      ),
      body: ListView.builder(
          itemCount: state.itemList.length,
          itemBuilder: (context, index) {
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
          }));
}
