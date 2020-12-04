import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'action.dart';
import 'state.dart';

/// @Author: smarthane
/// @GitHub: https://github.com/smarthane
/// @Description: 城市选择器
/// @Date: 2020/11/29


///
/// 参看 https://github.com/hanxu317317/city_pickers
/// 可以根据源码做自己的业务需求，按实现方式进行拓展 改造。
///

Widget buildView(
    CityPickersState state, Dispatch dispatch, ViewService viewService) {
  var themeData = state.store.themeModel.themeData;
  return Scaffold(
      appBar: AppBar(
        title: Text("城市选择器"),
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
                      dispatch(CityPickersActionCreator.onAction(index));
                }),
              );
            });
          }));
}
