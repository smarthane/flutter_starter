import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class ImagePickersPage extends Page<ImagePickersState, Map<String, dynamic>> {
  ImagePickersPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<ImagePickersState>(
                adapter: null,
                slots: <String, Dependent<ImagePickersState>>{
                }),
            middleware: <Middleware<ImagePickersState>>[
            ],);

}
