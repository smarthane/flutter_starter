import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_starter/common/resource_mananger.dart';
import 'package:flutter_starter/generated/l10n.dart';
import 'package:flutter_starter/widget/widget_bottom_clipper.dart';
import 'package:flutter_starter/widget/widget_login_field.dart';

import 'state.dart';

/// @Author: smarthane
/// @GitHub: https://github.com/smarthane
/// @Description:
/// @Date: 2020/11/29

Widget buildView(
    RegisterState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    body: CustomScrollView(
      physics: ClampingScrollPhysics(),
      slivers: <Widget>[
        SliverAppBar(
          floating: true,
        ),
        SliverToBoxAdapter(
          child: Stack(
            children: <Widget>[
              _buildRegisterTopPanel(state, dispatch, viewService),
              Container(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    _buildRegisterLogo(state, dispatch, viewService),
                    _buildRegisterFormContainer(state, dispatch, viewService),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    ),
  );
}

Widget _buildRegisterTopPanel(
    RegisterState state, Dispatch dispatch, ViewService viewService) {
  return ClipPath(
    clipper: BottomClipper(),
    child: Container(
      height: 220,
      color: state.store.themeModel.themeData.primaryColor,
    ),
  );
}

Widget _buildRegisterLogo(
    RegisterState state, Dispatch dispatch, ViewService viewService) {
  ThemeData themeData = state.store.themeModel.themeData;
  return new Container(
      child: Row(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      InkWell(
        child: Hero(
          tag: 'buildLoginLogo',
          child: Image.asset(ResourceHelper.wrapAssets('login_logo.png'),
              width: 130,
              height: 100,
              fit: BoxFit.fitWidth,
              color: themeData.brightness == Brightness.dark
                  ? themeData.accentColor
                  : Colors.white,
              // https://api.flutter.dev/flutter/dart-ui/BlendMode-class.html
              colorBlendMode: BlendMode.srcIn),
        ),
        onTap: () {},
      ),
    ],
  ));
}

Widget _buildRegisterFormContainer(
    RegisterState state, Dispatch dispatch, ViewService viewService) {
  ThemeData themeData = state.store.themeModel.themeData;
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
    decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(),
        color: themeData.cardColor,
        shadows: [
          BoxShadow(
              color: themeData.primaryColor.withAlpha(20),
              offset: Offset(1.0, 1.0),
              blurRadius: 10.0,
              spreadRadius: 3.0),
        ]),
    child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          LoginTextField(
            label: S.of(viewService.context).userName,
            icon: Icons.person_outline,
            controller: state.nameController,
            textInputAction: TextInputAction.next,
          ),
          LoginTextField(
            label: S.of(viewService.context).password,
            icon: Icons.lock_outline,
            obscureText: true,
            controller: state.passwordController,
            textInputAction: TextInputAction.next,
          ),
          LoginTextField(
            label: S.of(viewService.context).rePassword,
            icon: Icons.lock_outline,
            obscureText: true,
            controller: state.rePasswordController,
            textInputAction: TextInputAction.done,
            validator: (value) {
              return value != state.passwordController.text
                  ? S.of(viewService.context).twoPwdDifferent
                  : null;
            },
          ),
          Padding(
              padding: const EdgeInsets.fromLTRB(15, 40, 15, 20),
              child: CupertinoButton(
                padding: EdgeInsets.all(0),
                color: themeData.primaryColor.withAlpha(180),
                disabledColor: themeData.primaryColor.withAlpha(180),
                borderRadius: BorderRadius.circular(110),
                pressedOpacity: 0.5,
                child: Text(
                  S.of(viewService.context).signUp,
                  style:
                      themeData.accentTextTheme.title.copyWith(wordSpacing: 6),
                ),
                onPressed: () {},
              )),
        ]),
  );
}
