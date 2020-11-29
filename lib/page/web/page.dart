import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

/// @Author: smarthane
/// @GitHub: https://github.com/smarthane
/// @Description:
/// @Date: 2020/11/29

class WebviewPage extends Page<WebviewState, Map<String, dynamic>> {
  WebviewPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<WebviewState>(
              adapter: null, slots: <String, Dependent<WebviewState>>{}),
          middleware: <Middleware<WebviewState>>[],
        );
}
