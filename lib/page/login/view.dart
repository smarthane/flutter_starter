import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart' hide Action;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_starter/common/resource_mananger.dart';
import 'package:flutter_starter/generated/l10n.dart';
import 'package:flutter_starter/page/login/action.dart';
import 'package:flutter_starter/util/toast_utils.dart';
import 'package:flutter_starter/widget/widget_bottom_clipper.dart';
import 'package:flutter_starter/widget/widget_login_field.dart';

import 'state.dart';

/// @Author: smarthane
/// @GitHub: https://github.com/smarthane
/// @Description:
/// @Date: 2020/11/29

Widget buildView(LoginState state, Dispatch dispatch, ViewService viewService) {
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
              _buildLoginTopPanel(state, dispatch, viewService),
              Container(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    _buildLoginLogo(state, dispatch, viewService),
                    _buildLoginFormContainer(state, dispatch, viewService),
                    _buildThirdLoginContainer(state, dispatch, viewService)
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

Widget _buildLoginTopPanel(
    LoginState state, Dispatch dispatch, ViewService viewService) {
  return ClipPath(
    clipper: BottomClipper(),
    child: Container(
      height: 220,
      color: state.store.themeModel.themeData.primaryColor,
    ),
  );
}

Widget _buildLoginLogo(
    LoginState state, Dispatch dispatch, ViewService viewService) {
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

Widget _buildLoginFormContainer(
    LoginState state, Dispatch dispatch, ViewService viewService) {
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
            icon: Icons.perm_identity,
            controller: state.nameController,
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (text) {
              FocusScope.of(viewService.context).requestFocus(state.pwdFocus);
            },
          ),
          LoginTextField(
            label: S.of(viewService.context).password,
            icon: Icons.lock_outline,
            controller: state.passwordController,
            obscureText: true,
            focusNode: state.pwdFocus,
            textInputAction: TextInputAction.done,
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
                  S.of(viewService.context).signIn,
                  style:
                      themeData.accentTextTheme.title.copyWith(wordSpacing: 6),
                ),
                onPressed: () {},
              )),
          Center(
            child: Text.rich(
                TextSpan(text: S.of(viewService.context).noAccount, children: [
              TextSpan(
                  text: S.of(viewService.context).toSignUp,
                  recognizer: TapGestureRecognizer()
                    ..onTap = () async {
                      // 将注册成功的用户名,回填如登录框
                      dispatch(LoginActionCreator.onStartRegisterPage());
                    },
                  style: TextStyle(
                      color: Theme.of(viewService.context).accentColor))
            ])),
          )
        ]),
  );
}

Widget _buildThirdLoginContainer(
    LoginState state, Dispatch dispatch, ViewService viewService) {
  ThemeData themeData = state.store.themeModel.themeData;
  return Column(
    children: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            color: themeData.hintColor.withAlpha(50),
            height: 0.6,
            width: 60,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(S.of(viewService.context).signIn3thd,
                style: TextStyle(color: themeData.hintColor)),
          ),
          Container(
            color: themeData.hintColor.withAlpha(50),
            height: 0.6,
            width: 60,
          ),
        ],
      ),
      Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                ToastUtils.showText(S.of(viewService.context).waitInHope);
              },
              child: Image.asset(
                ResourceHelper.wrapAssets('logo_wechat.png'),
                width: 40,
                height: 40,
              ),
            ),
            GestureDetector(
              onTap: () {
                ToastUtils.showText(S.of(viewService.context).waitInHope);
              },
              child: Image.asset(
                ResourceHelper.wrapAssets('logo_weibo.png'),
                width: 40,
                height: 40,
              ),
            )
          ],
        ),
      )
    ],
  );
}
