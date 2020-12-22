import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'action.dart';
import 'state.dart';

/// @Author: smarthane
/// @GitHub: https://github.com/smarthane
/// @Description: https://github.com/tekartik/sqflite
/// @Date: 2020/11/29
/// 同时支持android和ios
/// 支持事务和批量操作
/// 支持插入/查询/更新/删除操作
/// 在iOS和Android上的后台线程中执行数据库操作

Widget buildView(SqliteState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("SQLite"),
      ),
      body: ListView.builder(
          itemCount: state.itemList.length,
          itemBuilder: (context, index) {
            return Builder(builder: (context) {
              return new Card(
                  child: new InkWell(
                    onTap: () {
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
