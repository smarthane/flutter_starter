import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action, Page;
import 'package:flutter_starter/widget/widget_keepalive_wrapper.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

/// @Author: smarthane
/// @GitHub: https://github.com/smarthane
/// @Description: 体系--> 选择相关知识点的详情页
/// @Date: 2020/11/29

class ArticlePage extends Page<ArticleState, Map<String, dynamic>> {
  ArticlePage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<ArticleState>(
                adapter: null, slots: <String, Dependent<ArticleState>>{}),
            middleware: <Middleware<ArticleState>>[],
            // 实现 `PageView` 子页面状态保持，不重复刷新
            wrapper: keepAliveWrapper);

  @override
  StateWithTickerProvider createState() => StateWithTickerProvider();
}

class StateWithTickerProvider extends ComponentState<ArticleState>
    with TickerProviderStateMixin {}
