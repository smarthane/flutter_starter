import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class SqlitePage extends Page<SqliteState, Map<String, dynamic>> {
  SqlitePage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<SqliteState>(
                adapter: null,
                slots: <String, Dependent<SqliteState>>{
                }),
            middleware: <Middleware<SqliteState>>[
            ],);

}
