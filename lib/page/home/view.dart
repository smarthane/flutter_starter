import 'dart:math';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_starter/common/app_manager.dart';
import 'package:flutter_starter/common/resource_mananger.dart';
import 'package:flutter_starter/generated/l10n.dart';

import 'action.dart';
import 'state.dart';

/// @Author: smarthane
/// @GitHub: https://github.com/smarthane
/// @Description:
/// @Date: 2020/11/29

Widget buildView(HomeState state, Dispatch dispatch, ViewService viewService) {
  List<String> titles = <String>[
    S.of(viewService.context).tabHome,
    S.of(viewService.context).tabProject,
    S.of(viewService.context).tabStructure,
    S.of(viewService.context).tabLegend,
  ];
  state.tabTitles = titles;
  return Scaffold(
      appBar: AppBar(
        title: Text(state.tabTitles[state.tabSelectedIndex]),
        //backgroundColor: state.store.theme.colorPrimary,
      ),
      body: WillPopScope(
        onWillPop: () {
          // 暂时去掉 按返回退出应用
          //if (Scaffold.of(viewService.context).isDrawerOpen) {
          //  Navigator.pop(viewService.context);
          //  return Future.value(false);
          //}
          //state.androidExitAppTip =
          //    S.of(viewService.context).tAndroidClickBackExitAppTip;
          //dispatch(HomeActionCreator.androidExitApp());
          return Future.value(true);
        },
        child: _bodyWidget(state, dispatch),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text(state.tabTitles[0]),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.format_list_bulleted),
            title: Text(state.tabTitles[1]),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.call_split),
            title: Text(state.tabTitles[2]),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera),
            title: Text(state.tabTitles[3]),
          ),
        ],
        currentIndex: state.tabSelectedIndex,
        onTap: (index) {
          state.tabPageController.jumpToPage(index);
          dispatch(HomeActionCreator.jumpTabPage(index));
        },
      ),
      drawer: _drawerWidget(state, dispatch, viewService));
}

Widget _bodyWidget(HomeState state, Dispatch dispatch) {
  return PageView.builder(
    itemBuilder: (ctx, index) => state.tabPages[index],
    itemCount: state.tabPages.length,
    controller: state.tabPageController,
    physics: NeverScrollableScrollPhysics(),
    onPageChanged: (index) {
      state.tabPageController.jumpToPage(index);
      dispatch(HomeActionCreator.jumpTabPage(index));
    },
  );
}

Widget _drawerWidget(
    HomeState state, Dispatch dispatch, ViewService viewService) {
  var accentColor = state.store.themeModel.themeData.accentColor;
  var primaryColor = state.store.themeModel.themeData.primaryColor;
  return Drawer(
    child: new Scaffold(
        body: CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          leading: Icon(null),
          actions: <Widget>[new Container()],
          backgroundColor: primaryColor,
          expandedHeight: 130 + MediaQuery.of(viewService.context).padding.top,
          pinned: false,
          flexibleSpace: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                InkWell(
                  child: Hero(
                    tag: 'loginLogo',
                    child: ClipOval(
                      child: Image.asset(
                          ResourceHelper.wrapAssets('user_avatar.png'),
                          fit: BoxFit.cover,
                          width: 80,
                          height: 80,
                          color: accentColor,
                          // https://api.flutter.dev/flutter/dart-ui/BlendMode-class.html
                          colorBlendMode: BlendMode.lighten),
                    ),
                  ),
                  onTap: () {
                    // 关闭抽屉
                    Navigator.pop(viewService.context);
                    // 跳转到登录 页面
                    dispatch(HomeActionCreator.startLoginPage());
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    S.of(viewService.context).toSignIn,
                    style: state.store.themeModel.themeData.textTheme.caption,
                  ),
                )
              ]),
        ),
        ListTileTheme(
          //textColor: state.store.theme.themeData().primaryColor,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 30, vertical: 2),
          child: SliverList(
            delegate: SliverChildListDelegate([
              SizedBox(
                height: 10,
              ),
              Material(
                child: ExpansionTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(S.of(viewService.context).switchFont),
                      Text(
                        Constants.fontName(state.store.themeModel.fontIndex,
                            viewService.context),
                        style:
                            state.store.themeModel.themeData.textTheme.caption,
                      )
                    ],
                  ),
                  leading: Icon(
                    Icons.font_download,
                    color: accentColor,
                  ),
                  children: <Widget>[
                    MediaQuery.removePadding(
                      removeTop: true,
                      removeLeft: true,
                      context: viewService.context,
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: Constants.fontValueList.length,
                          itemBuilder: (context, index) {
                            return RadioListTile(
                              value: index,
                              onChanged: (index) {
                                dispatch(
                                    HomeActionCreator.switchFontFamily(index));
                              },
                              groupValue: state.store.themeModel.fontIndex,
                              title: Text(Constants.fontName(index, context)),
                            );
                          }),
                    ),
                  ],
                ),
              ),
              Material(
                child: ExpansionTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(S.of(viewService.context).switchLanguage),
                      Text(
                        Constants.localeName(
                            state.store.localeModel.localeIndex,
                            viewService.context),
                        style:
                            state.store.themeModel.themeData.textTheme.caption,
                      )
                    ],
                  ),
                  leading: Icon(
                    Icons.public,
                    color: accentColor,
                  ),
                  children: <Widget>[
                    MediaQuery.removePadding(
                      removeTop: true,
                      removeLeft: true,
                      context: viewService.context,
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: Constants.localeValueList.length,
                          itemBuilder: (context, index) {
                            return RadioListTile(
                              value: index,
                              onChanged: (index) {
                                dispatch(HomeActionCreator.switchLocale(index));
                              },
                              groupValue: state.store.localeModel.localeIndex,
                              title: Text(Constants.localeName(
                                  index, viewService.context)),
                            );
                          }),
                    ),
                  ],
                ),
              ),
              ExpansionTile(
                title: Text(
                  S.of(viewService.context).switchTheme,
                  style: new TextStyle(decorationColor: accentColor),
                ),
                leading: Icon(
                  Icons.color_lens,
                  color: accentColor,
                ),

                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Wrap(
                      spacing: 5,
                      runSpacing: 5,
                      children: <Widget>[
                        ...Colors.primaries.map((color) {
                          return Material(
                            color: color,
                            child: InkWell(
                              onTap: () {
                                dispatch(HomeActionCreator.switchTheme(color));
                              },
                              child: Container(
                                width: 40,
                                height: 40,
                              ),
                            ),
                          );
                        }).toList(),
                        Material(
                          child: InkWell(
                            onTap: () {
                              dispatch(HomeActionCreator.switchTheme(null));
                            },
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: state.store.themeModel.themeData
                                          .accentColor)),
                              width: 40,
                              height: 40,
                              child: Text(
                                "?",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: state.store.themeModel.themeData
                                        .accentColor),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
                //trailing: Icon(Icons.pie_chart,color: accentColor),
              ),
              ListTile(
                title: Text(S.of(viewService.context).switchDarkMode),
                onTap: () {},
                leading: Transform.rotate(
                  angle: -pi,
                  child: Icon(
                    state.store.themeModel.darkMode
                        ? Icons.brightness_2
                        : Icons.brightness_5,
                    color: accentColor,
                  ),
                ),
                trailing: CupertinoSwitch(
                    activeColor: accentColor,
                    value: state.store.themeModel.themeData.brightness ==
                        Brightness.dark,
                    onChanged: (value) {
                      dispatch(HomeActionCreator.switchDarkMode(
                          !state.store.themeModel.darkMode));
                    }),
              ),
              ListTile(
                  title: Text(S.of(viewService.context).versionUpdate),
                  onTap: () {},
                  leading: Icon(
                    Icons.system_update,
                    color: accentColor,
                  )),
              ListTile(
                  title: Text(S.of(viewService.context).demos),
                  onTap: () {
                    dispatch(HomeActionCreator.startDemosPage());
                  },
                  leading: Icon(
                    Icons.developer_mode,
                    color: accentColor,
                  )),
              ListTile(
                  title: Text(S.of(viewService.context).appSetting),
                  onTap: () {
                    // 关闭抽屉
                    // Navigator.pop(viewService.context);
                    // 跳转到设置页面
                    dispatch(HomeActionCreator.startSettingPage());
                  },
                  leading: Icon(
                    Icons.settings,
                    color: accentColor,
                  )),
            ]),
          ),
        )
      ],
    )),
  );
}
