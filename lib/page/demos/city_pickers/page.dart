import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class CityPickersPage extends Page<CityPickersState, Map<String, dynamic>> {
  CityPickersPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<CityPickersState>(
                adapter: null,
                slots: <String, Dependent<CityPickersState>>{
                }),
            middleware: <Middleware<CityPickersState>>[
            ],);

}
