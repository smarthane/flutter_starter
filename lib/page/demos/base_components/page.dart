import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class BaseComponentsPage extends Page<BaseComponentsState, Map<String, dynamic>> {
  BaseComponentsPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<BaseComponentsState>(
                adapter: null,
                slots: <String, Dependent<BaseComponentsState>>{
                }),
            middleware: <Middleware<BaseComponentsState>>[
            ],);

}
