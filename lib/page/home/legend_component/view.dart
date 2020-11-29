import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_starter/api/model/article_model.dart';
import 'package:flutter_starter/global_store/store.dart';
import 'package:flutter_starter/page/common/common_article_skeleton.dart';
import 'package:flutter_starter/util/object_utils.dart';
import 'package:flutter_starter/widget/widget_image_wrapper.dart';
import 'package:flutter_starter/widget/widget_keepalive_wrapper.dart';
import 'package:flutter_starter/widget/widget_refresher_component.dart';
import 'package:flutter_starter/widget/widget_skeleton.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'action.dart';
import 'state.dart';

/// @Author: smarthane
/// @GitHub: https://github.com/smarthane
/// @Description:
/// @Date: 2020/11/29

/// 入口
Widget buildView(
    TabLegendState state, Dispatch dispatch, ViewService viewService) {
  /// TODO 网络请求异常 以及空处理

  /// 数据不为控显示数据
  if (state.treeList.isNotEmpty) {
    return Scaffold(
        appBar: AppBar(title: _buildTabBar(state, dispatch, viewService)),
        body: _buildTabBarView(state, dispatch, viewService));
  } else {
    return Center(child: CircularProgressIndicator());
  }
}

/// tab bar
Widget _buildTabBar(
    TabLegendState state, Dispatch dispatch, ViewService viewService) {
  /// 全局主题
  var themeData = IGlobalStore.ofThemeData(viewService.context);
  return Stack(
    children: [
      Container(
        child: Theme(
          data: themeData.copyWith(
            canvasColor: themeData.primaryColor,
          ),
          child: DropdownButtonHideUnderline(
              child: DropdownButton(
            elevation: 0,
            value: state.currentTabIndex,
            style: themeData.primaryTextTheme.subhead,
            items: List.generate(state.treeList.length, (index) {
              var subhead = themeData.primaryTextTheme.subhead;
              return DropdownMenuItem(
                value: index,
                child: Text(
                  state.treeList[index].name,
                  style: state.currentTabIndex == index
                      ? TextStyle(
                          fontSize: 30,
                          color: themeData.brightness == Brightness.light
                              ? Colors.white
                              : themeData.accentColor)
                      : subhead.apply(color: subhead.color.withAlpha(200)),
                ),
              );
            }),
            onChanged: (value) {
              state.tabController.animateTo(value);
            },
            isExpanded: true,
            icon: Container(
              child: Icon(
                Icons.keyboard_arrow_down,
                color: Colors.white,
              ),
            ),
          )),
        ),
      ),
      Container(
        margin: const EdgeInsets.only(left: 0, right: 25),
        color: themeData.primaryColor.withOpacity(1),
        child: TabBar(
            controller: state.tabController,
            isScrollable: true,
            tabs: List.generate(
                state.treeList.length,
                (index) => Tab(
                      text: state.treeList[index].name,
                    ))),
      )
    ],
  );
}

/// tab bar view
Widget _buildTabBarView(
    TabLegendState state, Dispatch dispatch, ViewService viewService) {
  return TabBarView(
    controller: state.tabController,
    children: List.generate(
      state.treeList.length,
      (index) => KeepAliveWidget(
          _buildArticleItemView(state, dispatch, viewService, index)),
    ),
  );
}

Widget _buildArticleItemView(TabLegendState state, Dispatch dispatch,
    ViewService viewService, int index) {
  /// TODO 网络请求异常 以及空处理

  /// 全局主题
  var themeData = IGlobalStore.ofThemeData(viewService.context);

  /// TabBarViewItemData
  var data = state.datas[state.idList[index]];

  /// 初始化加载数据
  if (data.articles.isEmpty && state.currentTabIndex == index) {
    return SkeletonList(
      builder: (context, index) => ArticleSkeletonItem(),
    );
  }

  return SmartRefresher(
      controller: data.refreshController,
      enablePullDown: true,
      enablePullUp: true,
      header: StarterRefreshHeader(),
      footer: StarterRefresherFooter(),
      onRefresh: () {
        dispatch(TabLegendActionCreator.onEffectRefresh(index));
      },
      onLoading: () {
        dispatch(TabLegendActionCreator.onEffectLoad(index));
      },
      child: ListView.builder(
          itemCount: data.articles.length,
          itemBuilder: (context, index) {
            Article article = data.articles[index];
            return Stack(
              children: <Widget>[
                Material(
                  child: InkWell(
                    onTap: () {
                      dispatch(TabLegendActionCreator.onOpenWebviewPage(
                          article.title, article.link));
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 0),
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                          border: Border(
                        bottom: Divider.createBorderSide(context, width: 0.7),
                      )),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              ClipOval(
                                child: WrapperImage(
                                  imageType: ImageType.random,
                                  url: article.author,
                                  height: 20,
                                  width: 20,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Text(
                                  ObjectUtils.isNotEmpty(article.author)
                                      ? article.author
                                      : article.shareUser,
                                  style: themeData.textTheme.caption,
                                ),
                              ),
                              Expanded(
                                child: SizedBox.shrink(),
                              ),
                              Text(article.niceDate,
                                  style: themeData.textTheme.caption),
                            ],
                          ),
                          if (article.envelopePic.isEmpty)
                            Padding(
                              padding: EdgeInsets.only(top: 7),
                              child: Html(
                                padding: EdgeInsets.symmetric(vertical: 5),
                                useRichText: false,
                                data: article.title,
                                defaultTextStyle: themeData.textTheme.subtitle,
                              ),
                            )
                          else
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Html(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 5),
                                        useRichText: false,
                                        data: article.title,
                                        defaultTextStyle:
                                            themeData.textTheme.subtitle,
                                      ),
                                      SizedBox(
                                        height: 2,
                                      ),
                                      Text(
                                        article.desc,
                                        style: themeData.textTheme.caption,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                WrapperImage(
                                  url: article.envelopePic,
                                  height: 60,
                                  width: 60,
                                ),
                              ],
                            ),
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 5),
                                child: Text(
                                  (article.superChapterName != null
                                          ? article.superChapterName + ' · '
                                          : '') +
                                      (article.chapterName ?? ''),
                                  style: themeData.textTheme.overline,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          }));
}
