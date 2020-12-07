import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_starter/common/resource_mananger.dart';
import 'package:flutter_starter/generated/l10n.dart';
import 'package:flutter_starter/route/route.dart';
import 'package:flutter_starter/widget/widget_click_item.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    AboutMeState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    appBar: AppBar(
      title: Text(S.of(viewService.context).aboutme),
    ),
    body: Column(
      children: <Widget>[
        FsGaps.vGap50,
        FlutterLogo(
          size: 100,
        ),
        FsGaps.vGap10,
        ClickItem(
            title: 'Github',
            content: 'Go Star',
            onTap: () {
              RouteManager.openWebViewPage(
                  url: "https://github.com/smarthane/flutter_starter",
                  title: "Go Star");
            }),
        ClickItem(
            title: '作者',
            content: 'smarthane',
            onTap: () {
              RouteManager.openWebViewPage(
                  url: "https://github.com/smarthane", title: "作者");
            }),
      ],
    ),
  );
}
