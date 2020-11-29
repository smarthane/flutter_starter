import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_starter/widget/widget_keepalive_wrapper.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

/// @Author: smarthane
/// @GitHub: https://github.com/smarthane
/// @Description:
/// @Date: 2020/11/29

class TabHomeComponent extends Component<TabHomeState> {
  TabHomeComponent()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<TabHomeState>(
                adapter: null, slots: <String, Dependent<TabHomeState>>{}),
            wrapper: keepAliveWrapper,
            shouldUpdate: (TabHomeState old, TabHomeState now) {
              return true;
            });

//  @override
//  bool get protectedClearOnDependenciesChanged => true;
}
