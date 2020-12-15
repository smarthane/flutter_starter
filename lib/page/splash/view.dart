import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_starter/common/app_manager.dart';
import 'package:flutter_starter/common/resource_mananger.dart';
import 'package:flutter_starter/generated/l10n.dart';
import 'package:lottie/lottie.dart';

import 'action.dart';
import 'state.dart';

/// @Author: smarthane
/// @GitHub: https://github.com/smarthane
/// @Description:
/// @Date: 2020/11/29

Widget buildView(
    SplashState state, Dispatch dispatch, ViewService viewService) {
  /// 设置适配尺寸 (填入设计稿中设备的屏幕尺寸)
  /// 注意放置位置 必须在materalapp home
  /// ???
  Config.screen(viewService.context);
  return Scaffold(
    body: WillPopScope(
      onWillPop: () => Future.value(false),
      child: Stack(fit: StackFit.expand, children: <Widget>[
        Image.asset(
            ResourceHelper.wrapAssets(
                state.store.themeModel.themeData.brightness == Brightness.light
                    ? 'splash_bg.png'
                    : 'splash_bg_dark.png'),
            fit: BoxFit.fill),
        Lottie.asset(
            state.randomAnimFile
                ? 'assets/animations/21372-launch-yourself.json'
                : 'assets/animations/39701-robot-bot-3d.json',
            alignment: Alignment(0.0, 0.7)),
//        AnimatedFlutterLogo(
//          animation: state.animation,
//        ),
//        Align(
//          alignment: Alignment(0.0, 0.7),
//          child: Row(
//            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//            children: <Widget>[
//              AnimatedAndroidLogo(
//                animation: state.animation,
//              ),
//            ],
//          ),
//        ),
        Align(
          alignment: Alignment.bottomRight,
          child: SafeArea(
            child: InkWell(
              onTap: () {
                dispatch(SplashActionCreator.onAction());
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                margin: EdgeInsets.only(right: 20, bottom: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: Colors.black.withAlpha(100),
                ),
                child: Text(
                  (state.count == 0 ? '' : '${state.count} | ') +
                      S.of(viewService.context).splashSkip,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        )
      ]),
    ),
  );
}

class AnimatedFlutterLogo extends AnimatedWidget {
  AnimatedFlutterLogo({
    Key key,
    Animation<double> animation,
  }) : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return AnimatedAlign(
      duration: Duration(milliseconds: 6),
      alignment: Alignment(0, 0.2 + animation.value * 0.3),
      curve: Curves.bounceOut,
      child: Image.asset(
        ResourceHelper.wrapAssets('splash_flutter.png'),
        width: 280,
        height: 160,
      ),
    );
  }
}

class AnimatedAndroidLogo extends AnimatedWidget {
  AnimatedAndroidLogo({
    Key key,
    Animation<double> animation,
  }) : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Image.asset(
          ResourceHelper.wrapAssets('splash_starter.png'),
          width: 200 * animation.value,
          height: 100 * animation.value,
        ),
        Image.asset(
          ResourceHelper.wrapAssets('splash_android.png'),
          width: 200 * (1 - animation.value),
          height: 100 * (1 - animation.value),
        ),
      ],
    );
  }
}
