import 'package:flutter_starter/generated/l10n.dart';

/// @Author: smarthane
/// @GitHub: https://github.com/smarthane
/// @Description:
/// @Date: 2020/11/29


/// 全局配置
class Config {}

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
}
