import 'dart:async';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_starter/common/app_manager.dart';
import 'dart:math';

import 'package:flutter_starter/common/resource_mananger.dart';

/// @Author: smarthane
/// @GitHub: https://github.com/smarthane
/// @Description: 版本更新 工具.
/// @Date: 2020/11/21
///
class VersionUpdateUtils {
  static UpdateDialog _dialog;

  static void check(BuildContext context) {
    BotToast.showText(text: "当前版本：${AppManager.packageInfo.version}");

    /// TODO 1.请求接口 校验版本信息
    if (_dialog != null && _dialog.isShowing()) {
      return;
    }

    /// TODO 2.显示弹窗
    _dialog = UpdateDialog.showUpdate(context,
        title: "是否升级到2.0.0版本？",
        updateContent:
            "新版本大小:10.0M\n1.又双叒修复了一大堆bug;\n2.祭天了多名程序猿;\n3.秃顶程序猿：“更了个寂寞”;\n4.更新前，你嘲笑我的bug。更新后，我让你高攀不起！",
        isForce: false,
        updateButtonText: '升级',
        ignoreButtonText: '忽略此版本',
        enableIgnore: true, onIgnore: () {
      BotToast.showText(text: "忽略此版本...");
      _dialog.dismiss();
    }, onUpdate: () {
      BotToast.showText(text: "开始下载...");

      /// TODO 3.下载安装包 到指定目录 首先获取存储权限
      ///  permission_handler: ^5.0.1+1
      ///
      /// 模拟下载更新
      ///
      double _progress = 0.0;
      Timer.periodic(Duration(milliseconds: 88), (timer) {
        _progress = _progress + 0.02;
        if (_progress > 1.0001) {
          BotToast.showText(text: "下载成功，开始安装...");

          /// TODO 4.下载成功进行安装
          /// 安装  调用 install_plugin
          /// 安卓：
          /// 校验权限 并安装
          /// Map<PermissionGroup, PermissionStatus> permissions =
          //        await PermissionHandler().requestPermissions([PermissionGroup.storage]);
          //    if (permissions[PermissionGroup.storage] == PermissionStatus.granted) {
          //      InstallPlugin.installApk(_apkFilePath, 'com.zaihui.installpluginexample')
          //          .then((result) {
          //        print('install apk $result');
          //      }).catchError((error) {
          //        print('install apk error: $error');
          //      });
          //    } else {
          //      print('Permission request fail!');
          //    }
          ///
          /// IOS:
          /// void onClickGotoAppStore(String url) {
          //    url = url.isEmpty
          //        ? 'url'
          //        : url;
          //    InstallPlugin.gotoAppStore(url);
          //  }
          timer.cancel();
          _dialog.dismiss();
          _progress = 0;
        } else {
          _dialog.update(_progress);
        }
      });
    });
  }
}

///版本更新加提示框
class UpdateDialog {
  bool _isShowing = false;
  BuildContext _context;
  UpdateWidget _widget;

  UpdateDialog(BuildContext context,
      {double width = 0.0,
      @required String title,
      @required String updateContent,
      @required VoidCallback onUpdate,
      double titleTextSize = 16.0,
      double contentTextSize = 14.0,
      double buttonTextSize = 14.0,
      double progress = -1.0,
      Color progressBackgroundColor = const Color(0xFFFFCDD2),
      Image topImage,
      double extraHeight = 5.0,
      double radius = 4.0,
      Color themeColor = Colors.red,
      bool enableIgnore = false,
      VoidCallback onIgnore,
      bool isForce = false,
      String updateButtonText,
      String ignoreButtonText,
      VoidCallback onClose}) {
    _context = context;
    _widget = UpdateWidget(
        width: width,
        title: title,
        updateContent: updateContent,
        onUpdate: onUpdate,
        titleTextSize: titleTextSize,
        contentTextSize: contentTextSize,
        buttonTextSize: buttonTextSize,
        progress: progress,
        topImage: topImage,
        extraHeight: extraHeight,
        radius: radius,
        themeColor: themeColor,
        progressBackgroundColor: progressBackgroundColor,
        enableIgnore: enableIgnore,
        onIgnore: onIgnore,
        isForce: isForce,
        updateButtonText: updateButtonText ?? '更新',
        ignoreButtonText: ignoreButtonText ?? '忽略此版本',
        onClose: onClose != null ? onClose : () => {dismiss()});
  }

  /// 显示弹窗
  Future<bool> show() {
    try {
      if (isShowing()) {
        return Future.value(false);
      }
      showDialog(
          context: _context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return WillPopScope(
                onWillPop: () => Future.value(false), child: _widget);
          });
      _isShowing = true;
      return Future.value(true);
    } catch (err) {
      _isShowing = false;
      return Future.value(false);
    }
  }

  /// 隐藏弹窗
  Future<bool> dismiss() {
    try {
      if (_isShowing) {
        _isShowing = false;
        Navigator.pop(_context);
        return Future.value(true);
      } else {
        return Future.value(false);
      }
    } catch (err) {
      return Future.value(false);
    }
  }

  /// 是否显示
  bool isShowing() {
    return _isShowing;
  }

  /// 更新进度
  void update(double progress) {
    if (isShowing()) {
      _widget.update(progress);
    }
  }

  /// 显示版本更新提示框
  static UpdateDialog showUpdate(BuildContext context,
      {double width = 0.0,
      @required String title,
      @required String updateContent,
      @required VoidCallback onUpdate,
      double titleTextSize = 16.0,
      double contentTextSize = 14.0,
      double buttonTextSize = 14.0,
      double progress = -1.0,
      Color progressBackgroundColor = const Color(0xFFFFCDD2),
      Image topImage,
      double extraHeight = 5.0,
      double radius = 4.0,
      Color themeColor = Colors.red,
      bool enableIgnore = false,
      VoidCallback onIgnore,
      String updateButtonText,
      String ignoreButtonText,
      bool isForce = false}) {
    UpdateDialog dialog = UpdateDialog(context,
        width: width,
        title: title,
        updateContent: updateContent,
        onUpdate: onUpdate,
        titleTextSize: titleTextSize,
        contentTextSize: contentTextSize,
        buttonTextSize: buttonTextSize,
        progress: progress,
        topImage: topImage,
        extraHeight: extraHeight,
        radius: radius,
        themeColor: themeColor,
        progressBackgroundColor: progressBackgroundColor,
        enableIgnore: enableIgnore,
        isForce: isForce,
        updateButtonText: updateButtonText,
        ignoreButtonText: ignoreButtonText,
        onIgnore: onIgnore);
    dialog.show();
    return dialog;
  }
}

// ignore: must_be_immutable
class UpdateWidget extends StatefulWidget {
  /// 对话框的宽度
  final double width;

  /// 升级标题
  final String title;

  /// 更新内容
  final String updateContent;

  /// 标题文字的大小
  final double titleTextSize;

  /// 更新文字内容的大小
  final double contentTextSize;

  /// 按钮文字的大小
  final double buttonTextSize;

  /// 顶部图片
  final Widget topImage;

  /// 拓展高度(适配顶部图片高度不一致的情况）
  final double extraHeight;

  /// 边框圆角大小
  final double radius;

  /// 主题颜色
  final Color themeColor;

  /// 更新事件
  final VoidCallback onUpdate;

  /// 可忽略更新
  final bool enableIgnore;

  /// 更新事件
  final VoidCallback onIgnore;

  double progress;

  /// 进度条的背景颜色
  final Color progressBackgroundColor;

  /// 更新事件
  final VoidCallback onClose;

  /// 是否是强制更新
  final bool isForce;

  /// 更新按钮内容
  final String updateButtonText;

  /// 忽略按钮内容
  final String ignoreButtonText;

  UpdateWidget(
      {Key key,
      this.width = 0.0,
      @required this.title,
      @required this.updateContent,
      @required this.onUpdate,
      this.titleTextSize = 16.0,
      this.contentTextSize = 14.0,
      this.buttonTextSize = 14.0,
      this.progress = -1.0,
      this.progressBackgroundColor = const Color(0xFFFFCDD2),
      this.topImage,
      this.extraHeight = 5.0,
      this.radius = 4.0,
      this.themeColor = Colors.red,
      this.enableIgnore = false,
      this.onIgnore,
      this.isForce = false,
      this.updateButtonText = '更新',
      this.ignoreButtonText = '忽略此版本',
      this.onClose})
      : super(key: key);

  _UpdateWidgetState _state = _UpdateWidgetState();

  update(double progress) {
    _state.update(progress);
  }

  @override
  _UpdateWidgetState createState() => _state;
}

class _UpdateWidgetState extends State<UpdateWidget> {
  update(double progress) {
    if (!mounted) {
      return;
    }
    setState(() {
      widget.progress = progress;
    });
  }

  @override
  Widget build(BuildContext context) {
    double dialogWidth =
        widget.width <= 0 ? getFitWidth(context) * 0.618 : widget.width;
    return Material(
        type: MaterialType.transparency,
        child: Container(
          child: SizedBox(
            width: dialogWidth,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: dialogWidth,
                  child: widget.topImage != null
                      ? widget.topImage
                      : ResourceHelper.loadImage(url: 'update_bg_app_top.png'),
                ),
                Container(
                  width: dialogWidth,
                  alignment: Alignment.center,
                  padding:
                      EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(widget.radius),
                          bottomRight: Radius.circular(widget.radius)),
                    ),
                  ),
                  child: SingleChildScrollView(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(top: widget.extraHeight),
                        child: Text(widget.title,
                            style: TextStyle(
                                fontSize: widget.titleTextSize,
                                color: Colors.black)),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Text(widget.updateContent,
                            style: TextStyle(
                                fontSize: widget.contentTextSize,
                                color: Color(0xFF666666))),
                      ),
                      widget.progress < 0
                          ? Column(children: <Widget>[
                              FractionallySizedBox(
                                widthFactor: 1,
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                  elevation: 0,
                                  highlightElevation: 0,
                                  child: Text(widget.updateButtonText,
                                      style: TextStyle(
                                          fontSize: widget.buttonTextSize)),
                                  color: widget.themeColor,
                                  textColor: Colors.white,
                                  onPressed: widget.onUpdate,
                                ),
                              ),
                              widget.enableIgnore && widget.onIgnore != null
                                  ? FractionallySizedBox(
                                      widthFactor: 1,
                                      child: FlatButton(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Text(widget.ignoreButtonText,
                                            style: TextStyle(
                                                fontSize:
                                                    widget.buttonTextSize)),
                                        materialTapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        textColor: Color(0xFF666666),
                                        onPressed: widget.onIgnore,
                                      ),
                                    )
                                  : SizedBox()
                            ])
                          : NumberProgress(
                              value: widget.progress,
                              backgroundColor: widget.progressBackgroundColor,
                              valueColor: widget.themeColor,
                              padding: EdgeInsets.symmetric(vertical: 10))
                    ],
                  )),
                ),
                !widget.isForce
                    ? Column(children: <Widget>[
                        SizedBox(
                            width: 1.5,
                            height: 50,
                            child: DecoratedBox(
                                decoration:
                                    BoxDecoration(color: Colors.white))),
                        IconButton(
                          iconSize: 30,
                          constraints:
                              BoxConstraints(maxHeight: 30, maxWidth: 30),
                          padding: EdgeInsets.zero,
                          icon: ResourceHelper.loadImage(
                              url: 'update_ic_close.png'),
                          onPressed: widget.onClose,
                        )
                      ])
                    : SizedBox()
              ],
            ),
          ),
        ));
  }

  double getFitWidth(BuildContext context) {
    return min(getScreenHeight(context), getScreenWidth(context));
  }

  double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }
}

/// 带进度文字的圆角进度条
class NumberProgress extends StatelessWidget {
  /// 进度条的高度
  final double height;

  /// 进度
  final double value;

  /// 进度条的背景颜色
  final Color backgroundColor;

  /// 进度条的色值
  final Color valueColor;

  /// 文字的颜色
  final Color textColor;

  /// 文字的大小
  final double textSize;

  /// 文字的对齐方式
  final AlignmentGeometry textAlignment;

  /// 边距
  final EdgeInsetsGeometry padding;

  NumberProgress(
      {Key key,
      this.height = 10.0,
      this.value = 0.0,
      this.backgroundColor,
      this.valueColor,
      this.textColor = Colors.white,
      this.textSize = 8.0,
      this.padding = EdgeInsets.zero,
      this.textAlignment = Alignment.center})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: padding,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            SizedBox(
              height: height,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(height)),
                child: LinearProgressIndicator(
                  value: value,
                  backgroundColor: backgroundColor,
                  valueColor: AlwaysStoppedAnimation<Color>(valueColor),
                ),
              ),
            ),
            Container(
              height: height,
              alignment: textAlignment,
              child: Text(
                value >= 1 ? '100%' : '${(value * 100).toInt()}%',
                style: TextStyle(
                  color: textColor,
                  fontSize: textSize,
                ),
              ),
            ),
          ],
        ));
  }
}
