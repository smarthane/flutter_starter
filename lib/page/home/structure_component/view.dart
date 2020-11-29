import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_starter/api/model/navigation_site_model.dart';
import 'package:flutter_starter/api/model/tree_model.dart';
import 'package:flutter_starter/global_store/store.dart';
import 'package:flutter_starter/widget/widget_keepalive_wrapper.dart';

import 'action.dart';
import 'state.dart';

/// @Author: smarthane
/// @GitHub: https://github.com/smarthane
/// @Description:
/// @Date: 2020/11/29

Widget buildView(
    TabStructureState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: TabBar(
            controller: state.tabController,
            isScrollable: true,
            tabs: List.generate(
                state.tabs.length,
                (index) => Tab(
                      text: state.tabs[index],
                    )),
          )),
      body: TabBarView(
        controller: state.tabController,
        children: List.generate(
          state.tabs.length,
          (index) => KeepAliveWidget(
              _TabBarViewItem(state, dispatch, viewService, index)),
        ),
      ));
}

Widget _TabBarViewItem(TabStructureState state, Dispatch dispatch,
    ViewService viewService, int index) {
  if (index == 0) {
    return _buildStructureCategoryList(state, dispatch, viewService);
  } else if (index == 1) {
    return _buildNavigationSiteCategoryList(state, dispatch, viewService);
  }
  return Container();
}

Widget _buildStructureCategoryList(
    TabStructureState state, Dispatch dispatch, ViewService viewService) {
  /// TODO 网络请求异常 以及空处理

  /// 全局主题
  var themeData = IGlobalStore.ofThemeData(viewService.context);
  if (state.treeList.isEmpty) {
    return Center(child: CircularProgressIndicator());
  }
  return Scrollbar(
    child: ListView.builder(
        padding: EdgeInsets.all(15),
        itemCount: state.treeList.length,
        itemBuilder: (context, index) {
          Tree tree = state.treeList[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  tree.name,
                  style: themeData.textTheme.subtitle,
                ),
                Wrap(
                    spacing: 10,
                    children: List.generate(
                        tree.children.length,
                        (index) => ActionChip(
                              onPressed: () {
                                dispatch(
                                    TabStructureActionCreator.onOpenArticalPage(
                                        tree, index));
                              },
                              label: Text(
                                tree.children[index].name,
                                maxLines: 1,
                              ),
                            )))
              ],
            ),
          );
        }),
  );
}

Widget _buildNavigationSiteCategoryList(
    TabStructureState state, Dispatch dispatch, ViewService viewService) {
  /// TODO 网络请求异常 以及空处理

  /// 全局主题
  var themeData = IGlobalStore.ofThemeData(viewService.context);
  if (state.navigationSiteList.isEmpty) {
    return Center(child: CircularProgressIndicator());
  }
  return Scrollbar(
    child: ListView.builder(
        padding: EdgeInsets.all(15),
        itemCount: state.navigationSiteList.length,
        itemBuilder: (context, index) {
          NavigationSite site = state.navigationSiteList[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  site.name,
                  style: themeData.textTheme.subtitle,
                ),
                Wrap(
                    spacing: 10,
                    children: List.generate(
                        site.articles.length,
                        (index) => ActionChip(
                              onPressed: () {
                                var article = site.articles[index];
                                dispatch(
                                    TabStructureActionCreator.onOpenWebviewPage(
                                        article.title, article.link));
                              },
                              label: Text(
                                site.articles[index].title,
                                maxLines: 1,
                              ),
                            )))
              ],
            ),
          );
        }),
  );
  ;
}
