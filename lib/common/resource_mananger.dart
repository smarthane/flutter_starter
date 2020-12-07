import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
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

  /// TODO
  static Widget loadImage(
      {@required String url,
      double width,
      double height,
      int cacheWidth,
      int cacheHeight,
      Color color,
      fit = BoxFit.cover}) {
    if (url.startsWith('http')) {
      return CachedNetworkImage(
        imageUrl: url,
        placeholder: (_, __) => placeHolder(width: width, height: height),
        errorWidget: (_, __, dynamic error) => error(width:width, height:height),
        width: width,
        height: height,
        fit: fit,
      );
    } else {
      return Image.asset(
        wrapAssets(url),
        height: height,
        width: width,
        cacheWidth: cacheWidth,
        cacheHeight: cacheHeight,
        fit: fit,
        color: color,

        /// 忽略图片语义
        excludeFromSemantics: true,
      );
    }
  }
}

/// //////////////////////////////////////////////////////////////////////////////
/// 通用全局的 icon color dimen style image
/// 类似原生安卓res下面的 values
/// 工程统一使用 统一规范
/// //////////////////////////////////////////////////////////////////////////////
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


class FsColors {
  static const Color app_main = Color(0xFF4688FA);
  static const Color dark_app_main = Color(0xFF3F7AE0);

  static const Color bg_color = Color(0xfff1f1f1);
  static const Color dark_bg_color = Color(0xFF18191A);

  static const Color material_bg = Color(0xFFFFFFFF);
  static const Color dark_material_bg = Color(0xFF303233);

  static const Color text = Color(0xFF333333);
  static const Color dark_text = Color(0xFFB8B8B8);

  static const Color text_gray = Color(0xFF999999);
  static const Color dark_text_gray = Color(0xFF666666);

  static const Color text_gray_c = Color(0xFFcccccc);
  static const Color dark_button_text = Color(0xFFF2F2F2);

  static const Color bg_gray = Color(0xFFF6F6F6);
  static const Color dark_bg_gray = Color(0xFF1F1F1F);

  static const Color line = Color(0xFFEEEEEE);
  static const Color dark_line = Color(0xFF3A3C3D);

  static const Color red = Color(0xFFFF4759);
  static const Color dark_red = Color(0xFFE03E4E);

  static const Color text_disabled = Color(0xFFD4E2FA);
  static const Color dark_text_disabled = Color(0xFFCEDBF2);

  static const Color button_disabled = Color(0xFF96BBFA);
  static const Color dark_button_disabled = Color(0xFF83A5E0);

  static const Color unselected_item_color = Color(0xffbfbfbf);
  static const Color dark_unselected_item_color = Color(0xFF4D4D4D);

  static const Color bg_gray_ = Color(0xFFFAFAFA);
  static const Color dark_bg_gray_ = Color(0xFF242526);
}

class FsDimens {
  static const double font_sp10 = 10.0;
  static const double font_sp12 = 12.0;
  static const double font_sp14 = 14.0;
  static const double font_sp15 = 15.0;
  static const double font_sp16 = 16.0;
  static const double font_sp18 = 18.0;

  static const double gap_dp4 = 4;
  static const double gap_dp5 = 5;
  static const double gap_dp8 = 8;
  static const double gap_dp10 = 10;
  static const double gap_dp12 = 12;
  static const double gap_dp15 = 15;
  static const double gap_dp16 = 16;
  static const double gap_dp24 = 24;
  static const double gap_dp32 = 32;
  static const double gap_dp50 = 50;
}

/// 间隔
/// 官方做法：https://github.com/flutter/flutter/pull/54394
class FsGaps {

  /// 水平间隔
  static const Widget hGap4 = SizedBox(width: FsDimens.gap_dp4);
  static const Widget hGap5 = SizedBox(width: FsDimens.gap_dp5);
  static const Widget hGap8 = SizedBox(width: FsDimens.gap_dp8);
  static const Widget hGap10 = SizedBox(width: FsDimens.gap_dp10);
  static const Widget hGap12 = SizedBox(width: FsDimens.gap_dp12);
  static const Widget hGap15 = SizedBox(width: FsDimens.gap_dp15);
  static const Widget hGap16 = SizedBox(width: FsDimens.gap_dp16);
  static const Widget hGap32 = SizedBox(width: FsDimens.gap_dp32);

  /// 垂直间隔
  static const Widget vGap4 = SizedBox(height: FsDimens.gap_dp4);
  static const Widget vGap5 = SizedBox(height: FsDimens.gap_dp5);
  static const Widget vGap8 = SizedBox(height: FsDimens.gap_dp8);
  static const Widget vGap10 = SizedBox(height: FsDimens.gap_dp10);
  static const Widget vGap12 = SizedBox(height: FsDimens.gap_dp12);
  static const Widget vGap15 = SizedBox(height: FsDimens.gap_dp15);
  static const Widget vGap16 = SizedBox(height: FsDimens.gap_dp16);
  static const Widget vGap24 = SizedBox(height: FsDimens.gap_dp24);
  static const Widget vGap32 = SizedBox(height: FsDimens.gap_dp32);
  static const Widget vGap50 = SizedBox(height: FsDimens.gap_dp50);

//  static Widget line = const SizedBox(
//    height: 0.6,
//    width: double.infinity,
//    child: const DecoratedBox(decoration: BoxDecoration(color: Colours.line)),
//  );

  static const Widget line = Divider();

  static const Widget vLine = SizedBox(
    width: 0.6,
    height: 24.0,
    child: VerticalDivider(),
  );

  static const Widget empty = SizedBox.shrink();
}

class FsImages {
  static Widget arrowRight = ResourceHelper.loadImage(url: 'ic_arrow_right.png', height: 16.0, width: 16.0);

}

class FsTextStyles {

  static const TextStyle textSize12 = TextStyle(
    fontSize: FsDimens.font_sp12,
  );
  static const TextStyle textSize16 = TextStyle(
    fontSize: FsDimens.font_sp16,
  );
  static const TextStyle textBold14 = TextStyle(
      fontSize: FsDimens.font_sp14,
      fontWeight: FontWeight.bold
  );
  static const TextStyle textBold16 = TextStyle(
      fontSize: FsDimens.font_sp16,
      fontWeight: FontWeight.bold
  );
  static const TextStyle textBold18 = TextStyle(
      fontSize: FsDimens.font_sp18,
      fontWeight: FontWeight.bold
  );
  static const TextStyle textBold24 = TextStyle(
      fontSize: 24.0,
      fontWeight: FontWeight.bold
  );
  static const TextStyle textBold26 = TextStyle(
      fontSize: 26.0,
      fontWeight: FontWeight.bold
  );

  static const TextStyle textGray14 = TextStyle(
    fontSize: FsDimens.font_sp14,
    color: FsColors.text_gray,
  );
  static const TextStyle textDarkGray14 = TextStyle(
    fontSize: FsDimens.font_sp14,
    color: FsColors.dark_text_gray,
  );

  static const TextStyle textWhite14 = TextStyle(
    fontSize: FsDimens.font_sp14,
    color: Colors.white,
  );

  static const TextStyle text = TextStyle(
      fontSize: FsDimens.font_sp14,
      color: FsColors.text,
      // https://github.com/flutter/flutter/issues/40248
      textBaseline: TextBaseline.alphabetic
  );
  static const TextStyle textDark = TextStyle(
      fontSize: FsDimens.font_sp14,
      color: FsColors.dark_text,
      textBaseline: TextBaseline.alphabetic
  );

  static const TextStyle textGray12 = TextStyle(
      fontSize: FsDimens.font_sp12,
      color: FsColors.text_gray,
      fontWeight: FontWeight.normal
  );
  static const TextStyle textDarkGray12 = TextStyle(
      fontSize: FsDimens.font_sp12,
      color: FsColors.dark_text_gray,
      fontWeight: FontWeight.normal
  );

  static const TextStyle textHint14 = TextStyle(
      fontSize: FsDimens.font_sp14,
      color: FsColors.dark_unselected_item_color
  );
}