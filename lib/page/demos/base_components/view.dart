import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'action.dart';
import 'state.dart';

/// @Author: smarthane
/// @GitHub: https://github.com/smarthane
/// @Description:
/// @Date: 2020/11/29

Widget buildView(BaseComponentsState state, Dispatch dispatch, ViewService viewService) {
  var themeData = state.store.themeModel.themeData;
  return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("基础组件示例"),
      ),
      body: ListView.builder(
          itemCount: state.itemList.length,
          itemBuilder: (context, index) {
            return Builder(builder: (context) {
              return Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: RaisedButton(
                    textColor: themeData.primaryColor,
                    child: Text(state.itemList[index]), onPressed: () {
                      dispatch(BaseComponentsActionCreator.onAction(index));
                }),
              );
            });
          }));
}
