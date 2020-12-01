import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_starter/api/model/navigation_site_model.dart';
import 'package:flutter_starter/api/model/tree_model.dart';
import 'package:flutter_starter/global_store/store.dart';
import 'package:flutter_starter/widget/widget_keepalive_wrapper.dart';
import 'package:flutter_starter/page/common/common_view_state_widget.dart';

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

// ignore: non_constant_identifier_names
Widget _TabBarViewItem(TabStructureState state, Dispatch dispatch,
    ViewService viewService, int index) {
  if (index == 0) {
    return _buildStructureCategoryList(state, dispatch, viewService);
  } else if (index == 1) {
    return _buildNavigationSiteCategoryList(state, dispatch, viewService);
  }
  return ViewStateZeroWidget();
}

Widget _buildStructureCategoryList(
    TabStructureState state, Dispatch dispatch, ViewService viewService) {
  /// 网络请求加载数据中
  if (state.treeViewStateMode.isLoad) {
    return ViewStateLoadWidget();
  }

  /// 网络请求异常
  if (state.treeViewStateMode.isError) {
    return ViewStateWidget(onPressed: () {
      dispatch(TabStructureActionCreator.onEActionLoadStructureCategory());
    });
  }

  /// 网络请求成功
  if (state.treeViewStateMode.isSuccess) {
    /// 全局主题
    var themeData = IGlobalStore.ofThemeData(viewService.context);
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
                                  dispatch(TabStructureActionCreator
                                      .onOpenArticalPage(tree, index));
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

  /// 网络请求成功返回空列表
  if (state.treeViewStateMode.isEmpty) {
    return ViewStateEmptyWidget(onPressed: () {
      dispatch(TabStructureActionCreator.onEActionLoadStructureCategory());
    });
  }

  return ViewStateZeroWidget();
}

Widget _buildNavigationSiteCategoryList(
    TabStructureState state, Dispatch dispatch, ViewService viewService) {
  /// 网络请求加载数据中
  if (state.siteViewStateMode.isLoad) {
    return ViewStateLoadWidget();
  }

  /// 网络请求异常
  if (state.siteViewStateMode.isError) {
    return ViewStateWidget(onPressed: () {
      dispatch(TabStructureActionCreator.onEActionLoadNavigationSiteCategory());
    });
  }

  /// 网络请求成功返回空列表
  if (state.siteViewStateMode.isEmpty) {
    return ViewStateEmptyWidget(onPressed: () {
      dispatch(TabStructureActionCreator.onEActionLoadNavigationSiteCategory());
    });
  }

  /// 网络请求成功
  if (state.siteViewStateMode.isSuccess) {
    /// 全局主题
    var themeData = IGlobalStore.ofThemeData(viewService.context);
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
                                  dispatch(TabStructureActionCreator
                                      .onOpenWebviewPage(
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
  }

  return ViewStateZeroWidget();
}
