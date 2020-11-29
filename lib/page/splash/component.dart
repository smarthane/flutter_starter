import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_starter/page/splash/state.dart';

/// @Author: smarthane
/// @GitHub: https://github.com/smarthane
/// @Description:
/// @Date: 2020/11/29

class SplashComponentState extends ComponentState<SplashState>
    with TickerProviderStateMixin {}

class SplashComponent extends Component<SplashState> {
  @override
  SplashComponentState createState() => SplashComponentState();
}
