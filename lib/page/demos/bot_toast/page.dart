import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action, Page;

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

/// @Author: smarthane
/// @GitHub: https://github.com/smarthane
/// @Description:
/// @Date: 2020/11/29

class BotToastPage extends Page<BotToastState, Map<String, dynamic>> {
  BotToastPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<BotToastState>(
                adapter: null,
                slots: <String, Dependent<BotToastState>>{
                }),
            middleware: <Middleware<BotToastState>>[
            ],);
  @override
  StateWithTickerProvider createState() => StateWithTickerProvider();
}

class StateWithTickerProvider extends ComponentState<BotToastState>
    with TickerProviderStateMixin {}
