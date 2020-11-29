import 'package:bot_toast/bot_toast.dart';

/// @Author: smarthane
/// @GitHub: https://github.com/smarthane
/// @Description: 提示信息工具类 基于bot_toast
/// @Date: 2020/11/29

class ToastUtils {
  static void showText(String text) {
    BotToast.showText(text: text);
  }
}
