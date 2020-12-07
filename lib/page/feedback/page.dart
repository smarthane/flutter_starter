import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class FeedbackPage extends Page<FeedbackState, Map<String, dynamic>> {
  FeedbackPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<FeedbackState>(
                adapter: null,
                slots: <String, Dependent<FeedbackState>>{
                }),
            middleware: <Middleware<FeedbackState>>[
            ],);

}
