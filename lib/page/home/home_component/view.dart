import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart' hide Action;
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_starter/api/model/article_model.dart';
import 'package:flutter_starter/common/resource_mananger.dart';
import 'package:flutter_starter/global_store/store.dart';
import 'package:flutter_starter/util/object_utils.dart';
import 'package:flutter_starter/widget/widget_image_wrapper.dart';
import 'package:flutter_starter/widget/widget_refresher_component.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'action.dart';
import 'state.dart';

/// @Author: smarthane
/// @GitHub: https://github.com/smarthane
/// @Description:
/// @Date: 2020/11/29

Widget buildView(
    TabHomeState state, Dispatch dispatch, ViewService viewService) {
  /// TODO 网络请求异常 以及空处理

  /// TODO 加载数据处理

  if (state.banners.isEmpty) {
    return Center(child: CircularProgressIndicator());
  } else {
    /// banner高度设置
    var bannerHeight = MediaQuery.of(viewService.context).size.width * 5 / 11;

    /// 全局主题
    var themeData = IGlobalStore.ofThemeData(viewService.context);
    return Scaffold(
      body: MediaQuery.removePadding(
        context: viewService.context,
        removeTop: false,
        child: SmartRefresher(
          enablePullDown: true,
          enablePullUp: true,
          header: StarterRefreshHeader(),
          footer: StarterRefresherFooter(),
          controller: state.refreshController,
          onRefresh: () {
            dispatch(TabHomeActionCreator.onEffectRefresh());
          },
          onLoading: () {
            dispatch(TabHomeActionCreator.onEffectLoad(++state.currentPageNum));
          },
          child: CustomScrollView(controller: state.scrollController, slivers: <
              Widget>[
            SliverAppBar(
              backgroundColor: Colors.transparent,
              flexibleSpace: FlexibleSpaceBar(
                background: Swiper(
                  loop: true,
                  autoplay: true,
                  autoplayDelay: 5000,
                  pagination: SwiperPagination(),
                  itemCount: state.banners.length,
                  itemHeight: bannerHeight,
                  itemBuilder: (ctx, index) {
                    return InkWell(
                        onTap: () {
                          var banner = state.banners[index];
                          dispatch(TabHomeActionCreator.onOpenWebviewPage(
                              banner.title, banner.url));
                        },
                        child: CachedNetworkImage(
                            imageUrl: ResourceHelper.wrapUrl(
                                state.banners[index].imagePath),
                            placeholder: (context, url) =>
                                Center(child: CupertinoActivityIndicator()),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                            fit: BoxFit.fill));
                  },
                ),
                centerTitle: true,
              ),
              expandedHeight: bannerHeight,
              pinned: false,
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  Article article = state.articles[index];
                  return Stack(
                    children: <Widget>[
                      Material(
                        child: InkWell(
                          onTap: () {
                            dispatch(TabHomeActionCreator.onOpenWebviewPage(
                                article.title, article.link));
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 0),
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                                border: Border(
                              bottom:
                                  Divider.createBorderSide(context, width: 0.7),
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
                                      padding:
                                          EdgeInsets.symmetric(vertical: 5),
                                      useRichText: false,
                                      data: article.title,
                                      defaultTextStyle:
                                          themeData.textTheme.subtitle,
                                    ),
                                  )
                                else
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Html(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 5),
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
                                              style:
                                                  themeData.textTheme.caption,
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
                                      padding:
                                          EdgeInsets.symmetric(vertical: 5),
                                      child: Text(
                                        (article.superChapterName != null
                                                ? article.superChapterName +
                                                    ' · '
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
                },
                childCount: state.articles.length,
              ),
            ),
          ]),
        ),
      ),
      floatingActionButton: AnimatedSwitcher(
        duration: Duration(milliseconds: 0),
        switchInCurve: Curves.elasticInOut,
        switchOutCurve: Curves.elasticInOut,
        transitionBuilder: (child, animation) => ScaleTransition(
          scale: animation,
          child: child,
        ),
        child: state.showTopBtn
            ? FloatingActionButton(
                heroTag: 'scrollTop',
                key: ValueKey(Icons.vertical_align_top),
                onPressed: () {
                  state.scrollController.animateTo(0,
                      duration: Duration(milliseconds: 200),
                      curve: Curves.elasticInOut);
                },
                child: Icon(
                  Icons.vertical_align_top,
                ),
              )
            : Container(),
      ),
    );
  }
}
