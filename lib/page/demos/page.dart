import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

/// @Author: smarthane
/// @GitHub: https://github.com/smarthane
/// @Description:
/// @Date: 2020/11/29

class DemosPage extends Page<DemosState, Map<String, dynamic>> {
  DemosPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<DemosState>(
                adapter: null,
                slots: <String, Dependent<DemosState>>{
                }),
            middleware: <Middleware<DemosState>>[
            ],);

}
