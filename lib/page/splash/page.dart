import 'package:fish_redux/fish_redux.dart';

import 'component.dart';
import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

/// @Author: smarthane
/// @GitHub: https://github.com/smarthane
/// @Description:
/// @Date: 2020/11/29

class SplashPage extends Page<SplashState, Map<String, dynamic>> {
  SplashPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<SplashState>(
              adapter: null, slots: <String, Dependent<SplashState>>{}),
          middleware: <Middleware<SplashState>>[],
        );

  @override
  ComponentState<SplashState> createState() {
    return SplashComponentState();
  }
}
