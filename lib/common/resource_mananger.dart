import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// @Author: smarthane
/// @GitHub: https://github.com/smarthane
/// @Description:
/// @Date: 2020/11/29

class ResourceHelper {
  static const String baseUrl = 'http://www.meetingplus.cn';
  static const String imagePrefix = '$baseUrl/uimg/';

  static String wrapUrl(String url) {
    if (url.startsWith('http')) {
      return url;
    } else {}
    return imagePrefix + url;
  }

  static String wrapAssets(String url) {
    return "assets/images/" + url;
  }

  static Widget placeHolder({double width, double height}) {
    return SizedBox(
        width: width,
        height: height,
        child: CupertinoActivityIndicator(radius: min(10.0, width / 3)));
  }

  static Widget error({double width, double height, double size}) {
    return SizedBox(
        width: width,
        height: height,
        child: Icon(
          Icons.error_outline,
          size: size,
        ));
  }

  static String randomUrl(
      {int width = 100, int height = 100, Object key = ''}) {
    return 'http://placeimg.com/$width/$height/${key.hashCode.toString() + key.toString()}';
  }
}

class IconFonts {
  IconFonts._();

  static const String fontFamily = 'iconfont';

  static const IconData pageEmpty = IconData(0xe63c, fontFamily: fontFamily);
  static const IconData pageError = IconData(0xe600, fontFamily: fontFamily);
  static const IconData pageUnAuthorized =
      IconData(0xe65f, fontFamily: fontFamily);
  static const IconData train = IconData(0xe89a, fontFamily: fontFamily);
  static const IconData hotel = IconData(0xe8a0, fontFamily: fontFamily);
}
