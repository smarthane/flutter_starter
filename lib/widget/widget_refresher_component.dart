import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// @Author: smarthane
/// @GitHub: https://github.com/smarthane
/// @Description:
/// @Date: 2020/11/29

/// 通用的header
class StarterRefreshHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WaterDropHeader();
  }
}

/// 通用的footer
class StarterRefresherFooter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClassicFooter();
  }
}
