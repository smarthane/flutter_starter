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

Widget buildView(
    ArticleState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(state.tree.name),
        bottom: TabBar(
            controller: state.tabController,
            isScrollable: true,
            tabs: List.generate(
                state.tree.children.length,
                (index) => Tab(
                      text: state.tree.children[index].name,
                    ))),
      ),
      body: TabBarView(
        controller: state.tabController,
        children: List.generate(
            state.tree.children.length,
            (index) => KeepAliveWidget(
                _buildArticleItemView(state, dispatch, viewService, index))),
      ));
}

Widget _buildArticleItemView(
    ArticleState state, Dispatch dispatch, ViewService viewService, int index) {
  /// TODO 网络请求异常 以及空处理

  /// 全局主题
  var themeData = IGlobalStore.ofThemeData(viewService.context);

  /// ArticleItemData
  var data = state.datas[state.idList[index]];

  /// 初始化加载数据
  if (data.articles.isEmpty && state.tabIndex == index) {
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
        dispatch(ArticleActionCreator.onEActionRefresh(index));
      },
      onLoading: () {
        dispatch(ArticleActionCreator.onEActionLoad(index));
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
                      dispatch(ArticleActionCreator.onOpenWebviewPage(
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
