import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_starter/widget/widget_keepalive_wrapper.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

/// @Author: smarthane
/// @GitHub: https://github.com/smarthane
/// @Description:
/// @Date: 2020/11/29

class TabProjectComponent extends Component<TabProjectState> {
  TabProjectComponent()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<TabProjectState>(
                adapter: null, slots: <String, Dependent<TabProjectState>>{}),
            wrapper: keepAliveWrapper,
            shouldUpdate: (TabProjectState old, TabProjectState now) {
              return true;
            });

  @override
  StateWithTickerProvider createState() => StateWithTickerProvider();
}

class StateWithTickerProvider extends ComponentState<TabProjectState>
    with TickerProviderStateMixin {}
