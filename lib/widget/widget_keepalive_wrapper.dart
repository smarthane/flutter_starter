import 'package:flutter/material.dart';

/// @Author: smarthane
/// @GitHub: https://github.com/smarthane
/// @Description:
/// @Date: 2020/11/29

class KeepAliveWidget extends StatefulWidget {
  final Widget child;

  KeepAliveWidget(this.child);

  @override
  _KeepAliveWidgetState createState() => _KeepAliveWidgetState();
}

class _KeepAliveWidgetState extends State<KeepAliveWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  bool get wantKeepAlive => true;
}

Widget keepAliveWrapper(Widget child) => KeepAliveWidget(child);
