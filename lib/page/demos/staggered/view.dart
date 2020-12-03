import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_starter/widget/widget_refresher_component.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'action.dart';
import 'state.dart';

/// @Author: smarthane
/// @GitHub: https://github.com/smarthane
/// @Description:
/// @Date: 2020/11/29

///
/// 瀑布流 A Flutter staggered grid view which supports multiple columns with rows of varying sizes.
/// https://github.com/letsar/flutter_staggered_grid_view
/// 详细使用参考作者提供的examples
/// flutter_staggered_grid_view: ^0.3.2
///
/// new StaggeredGridView.countBuilder(
///  crossAxisCount: 4,
///  itemCount: 8,
///  itemBuilder: (BuildContext context, int index) => new Container(
///      color: Colors.green,
///      child: new Center(
///        child: new CircleAvatar(
///          backgroundColor: Colors.white,
///          child: new Text('$index'),
///        ),
///      )),
///  staggeredTileBuilder: (int index) =>
///      new StaggeredTile.count(2, index.isEven ? 2 : 1),
///  mainAxisSpacing: 4.0,
///  crossAxisSpacing: 4.0,
///)
///

Widget buildView(
    StaggeredState state, Dispatch dispatch, ViewService viewService) {
  var themeData = state.store.themeModel.themeData;
  return Scaffold(
    appBar: AppBar(
      title: Text("瀑布流示例"),
    ),
    body: Padding(
      padding: const EdgeInsets.only(top: 2.0),
      child: SmartRefresher(
        enablePullDown: true,
        enablePullUp: false,
        header: StarterRefreshHeader(),
        footer: StarterRefresherFooter(),
        controller: state.refreshController,
        onRefresh: () {
          dispatch(StaggeredActionCreator.onReducerRefresh());
        },
        onLoading: () {
          dispatch(StaggeredActionCreator.onReducerLoad());
        },
        child: StaggeredGridView.countBuilder(
          crossAxisCount: 4,
          itemCount: state.itemList.length,
          itemBuilder: (BuildContext context, int index) => new Container(
              child: new Card(
            child: new InkWell(
              onTap: () {},
              child: new Column(
                children: <Widget>[
                  CachedNetworkImage(
                      imageUrl: state.itemList[index].imageUrl,
                      placeholder: (context, url) =>
                          Center(child: CupertinoActivityIndicator()),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      fit: BoxFit.fill),
                  new Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: new Column(
                      children: <Widget>[
                        new Text(
                          state.itemList[index].name,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.normal,
                              color: themeData.accentColor),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )),
          staggeredTileBuilder: (int index) => new StaggeredTile.fit(2),
          mainAxisSpacing: 2.0,
          crossAxisSpacing: 2.0,
        ),
      ),
    ),
  );
}
