import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_starter/generated/l10n.dart';
import 'package:package_info/package_info.dart';

/// @Author: smarthane
/// @GitHub: https://github.com/smarthane
/// @Description:
/// @Date: 2020/11/29

/// 应用管理
class AppManager {
  /// 应用包信息
  static PackageInfo packageInfo;

  static init() async {
    packageInfo = await PackageInfo.fromPlatform();
  }
}

/// 全局配置
class Config {

  /// 配置屏幕适配
  /// https://github.com/OpenFlutter/flutter_screenutil
  /// flutter 屏幕适配方案，让你的UI在不同尺寸的屏幕上都能显示合理的布局!
  static void screen(BuildContext context) {
    /// 设置适配尺寸 (填入设计稿中设备的屏幕尺寸)
    /// 默认 width : 1080px , height:1920px , allowFontScaling:false
    ScreenUtil.init(context);
    //设置适配尺寸 (填入设计稿中设备的屏幕尺寸) 此处假如设计稿是按iPhone6的尺寸设计的(iPhone6 750*1334)
    //ScreenUtil.init(context, designSize: Size(750, 1334), allowFontScaling: false);
    //假如设计稿是按iPhone6的尺寸设计的(iPhone6 750*1334)
    //ScreenUtil.init(context, designSize: Size(750, 1334));
    //设置字体大小根据系统的“字体大小”辅助选项来进行缩放,默认为false
    //ScreenUtil.init(context, designSize: Size(750, 1334), allowFontScaling: true);
  }
}

/// 全局常量定义
class Constants {
  /// 存储颜色的键值
  static const KEY_THEME_MATERIAL_COLOR = 'key_theme_material_color';

  /// 存储字体索引的键值
  static const KEY_THEME_FONT_INDEX = 'key_theme_font_index';

  /// 存储是否为默认模式键值
  static const KEY_THEME_DARK_MODE = 'key_theme_dark_mode';

  /// 存储语言索引的键值
  static const KEY_THEME_LOCALE_INDEX = 'key_theme_locale_index';

  /// 是否使用Webview plugin
  static const KEY_USE_WEBVIEW_PLUGIN = 'key_use_webview_plugin';

  /// 存储用户信息的键值
  static const KEY_USER_INFO = 'key_user_info';

  /// 提供的字体库列表
  static const fontValueList = ['system', 'happy', 'butter'];

  /// 提供的语言列表 i18n 国际化
  static const localeValueList = ['', 'zh-CN', 'en'];

  /// 语言文字显示
  static String localeName(index, context) {
    switch (index) {
      case 0:
        return S.of(context).autoBySystem;
      case 1:
        return '中文';
      case 2:
        return 'English';
      default:
        return '';
    }
  }

  /// 字体名称显示
  static String fontName(index, context) {
    switch (index) {
      case 0:
        return S.of(context).fontSystem;
      case 1:
        return S.of(context).fontHappy;
      case 2:
        return S.of(context).fontButter;
      default:
        return '';
    }
  }

  /// 纯白色主题
  static const MaterialColor WHITE = MaterialColor(0xFFFFFFFF, <int, Color>{
    50: Color(0xFFFFF0F5),
    100: Color(0xFFFFFFF0),
    200: Color(0xFFE6E6FA),
    300: Color(0xFFF0F8FF),
    400: Color(0xFFF0FFFF),
    500: Color(0xFFFFFAF0),
    600: Color(0xFFF5F5F5),
    700: Color(0xFFF8F8FF),
    800: Color(0xFFFFFAFA),
    900: Color(0xFFFFFFFF),
  });

  /// 纯黑色主题
  static const MaterialColor BLACK = MaterialColor(0xFF000000, <int, Color>{
    50: Colors.black12,
    100: Colors.black12,
    200: Colors.black12,
    300: Colors.black12,
    400: Colors.black26,
    500: Colors.black38,
    600: Colors.black45,
    700: Colors.black54,
    800: Colors.black87,
    900: Colors.black,
  });

  /// 主题颜色库
  static List<MaterialColor> colors = []
    ..addAll(Colors.primaries)

    /// 纯白色主题
    ..add(WHITE)

    /// 纯黑色主题
    ..add(BLACK);
}
