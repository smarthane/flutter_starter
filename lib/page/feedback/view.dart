import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_starter/generated/l10n.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(FeedbackState state, Dispatch dispatch, ViewService viewService) {
  var themeData = state.store.themeModel.themeData;
  return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(S.of(viewService.context).feedback),
      ),
      body: Text(""));
}
