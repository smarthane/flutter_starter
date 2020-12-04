import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_starter/generated/l10n.dart';
import 'package:flutter_starter/widget/widget_refresher_component.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'action.dart';
import 'state.dart';

/// @Author: smarthane
/// @GitHub: https://github.com/smarthane
/// @Description: 开发示例入口
/// @Date: 2020/11/29

Widget buildView(DemosState state, Dispatch dispatch, ViewService viewService) {
  var themeData = state.store.themeModel.themeData;
  return Scaffold(
    appBar: AppBar(
      title: Text(S.of(viewService.context).demos),
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
          dispatch(DemosActionCreator.onReducerRefresh());
        },
        onLoading: () {
          dispatch(DemosActionCreator.onReducerLoad());
        },
        child: StaggeredGridView.countBuilder(
          crossAxisCount: 4,
          itemCount: state.itemList.length,
          itemBuilder: (BuildContext context, int index) => new Container(
              child: new Card(
            borderOnForeground: false,
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: new InkWell(
                onTap: () {
                  Navigator.of(viewService.context)
                      .pushNamed(state.itemList[index].pageRoute);
                },
                child: new Column(
                  children: <Widget>[
                    Image.asset(state.itemList[index].imageUrl),
                    new Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Center(
                        child: new Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            new Text(
                              state.itemList[index].title,
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: themeData.accentColor),
                            ),
                            new Text(
                              state.itemList[index].subTitle,
                              style: TextStyle(
                                  fontSize: 8,
                                  fontWeight: FontWeight.normal,
                                  color: themeData.accentColor),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )),
          staggeredTileBuilder: (int index) => new StaggeredTile.fit(1),
          mainAxisSpacing: 2.0,
          crossAxisSpacing: 2.0,
        ),
      ),
    ),
  );
}
