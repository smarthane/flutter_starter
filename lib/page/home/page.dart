import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_starter/page/home/home_component/component.dart';
import 'package:flutter_starter/page/home/project_component/component.dart';
import 'package:flutter_starter/page/home/structure_component/component.dart';
import 'package:flutter_starter/widget/widget_keepalive_wrapper.dart';

import 'effect.dart';
import 'legend_component/component.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

/// @Author: smarthane
/// @GitHub: https://github.com/smarthane
/// @Description:
/// @Date: 2020/11/29

class HomePage extends Page<HomeState, Map<String, dynamic>> {
  HomePage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<HomeState>(
                adapter: null,
                slots: <String, Dependent<HomeState>>{
                  "tabHome": TabHomeConnector() + TabHomeComponent(),
                  "tabProject": TabProjectConnector() + TabProjectComponent(),
                  "tabStructure":
                      TabStructureConnector() + TabStructureComponent(),
                  "tabLegend": TabLegendConnector() + TabLegendComponent(),
                }),
            middleware: <Middleware<HomeState>>[],
            // 实现 `PageView` 子页面状态保持，不重复刷新
            wrapper: keepAliveWrapper);
}
