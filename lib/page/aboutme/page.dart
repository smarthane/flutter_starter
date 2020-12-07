import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class AboutMePage extends Page<AboutMeState, Map<String, dynamic>> {
  AboutMePage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<AboutMeState>(
                adapter: null,
                slots: <String, Dependent<AboutMeState>>{
                }),
            middleware: <Middleware<AboutMeState>>[
            ],);

}
