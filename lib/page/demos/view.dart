import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_starter/generated/l10n.dart';

import 'action.dart';
import 'state.dart';

/// @Author: smarthane
/// @GitHub: https://github.com/smarthane
/// @Description:
/// @Date: 2020/11/29

Widget buildView(DemosState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    appBar: AppBar(
      title: Text(S.of(viewService.context).demos),
    ),
    body: Container(
      child: Text("Demos"),
    ),
  );
}
