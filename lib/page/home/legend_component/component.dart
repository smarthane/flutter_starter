import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_starter/widget/widget_keepalive_wrapper.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

/// @Author: smarthane
/// @GitHub: https://github.com/smarthane
/// @Description:
/// @Date: 2020/11/29

class TabLegendComponent extends Component<TabLegendState> {
  TabLegendComponent()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<TabLegendState>(
                adapter: null, slots: <String, Dependent<TabLegendState>>{}),
            wrapper: keepAliveWrapper,
            shouldUpdate: (TabLegendState old, TabLegendState now) {
              return true;
            });

  @override
  StateWithTickerProvider createState() => StateWithTickerProvider();
}

class StateWithTickerProvider extends ComponentState<TabLegendState>
    with TickerProviderStateMixin {}
