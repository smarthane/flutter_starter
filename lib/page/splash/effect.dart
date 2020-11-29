import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_starter/page/splash/component.dart';
import 'package:flutter_starter/route/route.dart';
import 'package:flutter_starter/util/timer_utils.dart';

import 'action.dart';
import 'state.dart';

/// @Author: smarthane
/// @GitHub: https://github.com/smarthane
/// @Description:
/// @Date: 2020/11/29

Effect<SplashState> buildEffect() {
  return combineEffects(<Object, Effect<SplashState>>{
    Lifecycle.initState: _onInitState,
    Lifecycle.dispose: _onDispose,
    SplashAction.ACTION: _onAction,
  });
}

_onInitState(Action action, Context<SplashState> ctx) {
  final TickerProvider tickerProvider = ctx.stfState as SplashComponentState;
  AnimationController _logoController = AnimationController(
      vsync: tickerProvider, duration: Duration(milliseconds: 1500));

  Animation<double> _animation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(curve: Curves.easeInOutBack, parent: _logoController));

  _animation.addStatusListener((status) {
    if (status == AnimationStatus.completed) {
      _logoController.reverse();
    } else if (status == AnimationStatus.dismissed) {
      _logoController.forward();
    }
  });
  _logoController.forward();

  ctx.state.logoController = _logoController;
  ctx.state.animation = _animation;

  TimerUtils _timerUtil =
      new TimerUtils(mTotalTime: SplashState.LIMIT_TIME_COUNT * 1000);
  _timerUtil.setOnTimerTickCallback((int tick) {
    double _tick = tick / 1000;
    if (_tick == 0) {
      _onAction(action, ctx);
    } else {
      ctx.dispatch(SplashActionCreator.onCountDown(_tick.toInt()));
    }
  });
  _timerUtil.startCountDown();
  ctx.state.timerUtils = _timerUtil;
}

_onDispose(Action action, Context<SplashState> ctx) {}

_onAction(Action action, Context<SplashState> ctx) {
  ctx.state.logoController.dispose();
  if (ctx.state.timerUtils != null) {
    ctx.state.timerUtils.cancel();
  }
  Future.delayed(Duration.zero, () {
    Navigator.pushReplacementNamed(ctx.context, RouteManager.homePage);
  });
}
