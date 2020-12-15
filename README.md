
<br/>
<br/>
<p align="center">
  <a href="https://github.com/smarthane/flutter_starter">
    <img src="docs/images/flutter_starter_logo.jpg" alt="Logo" width="160" height="160">
  </a>
  <h3 align="center">Flutter Starter</h3>
  <p align="center">
    🔥👍基于fish_redux的纯flutter快速开发框架。框架集成黑夜模式、多色彩主题、国际化、切换字体、优美动画，以及各种常见的、丰富的开发示例。可以让你快速的上手开发一个移动应用APP(Android\iOS)。希望和大家共同成长，喜欢的话，欢迎start或fork!
    <br/>
    <br/>
    <br/>
  </p>
</p>

### :computer: 一、代码编译说明

- 当前代码的Flutter SDK 版本：1.17.3-stable（flutter SDK >= 1.17.3-stable目前都支持建议可以用最新的SDK版本）。
- 项目整体结构以及状态管理使用Fish Redux（action、effect、page、reducer、state、view）。
- 项目国际化方案使用flutter_intl方案（需要AS安装Flutter Intl插件）。
- 框架中网络请求数据来自玩android。
- 代码支持安卓和iOS。

### :house: 二、架构图


### :1st_place_medal: 三、项目样图


### :file_folder: 四、工程目录说明

```
flutter_starter 
├── android<-----------------------原生安卓目录
├── assets<------------------------Flutter资源目录
│  ├── /animations/<---------------动画文件
│  ├── /fonts/<--------------------字体文件
│  └── /images/<-------------------图片文件
├── /docs/<------------------------项目介绍操作文档
├── /ios/<-------------------------原生iOS目录
├── lib
│  |── /api/<----------------------网络交互
│  │── /broadcast/<----------------全局广播（类似EventBus）
│  │── /common/<-------------------框架基础管理
│  |── /generated/<----------------Flutter Intl国际化动态生成目录
│  │── /global_store/<-------------全局状态管理
│  │── /I10n/<---------------------Flutter Intl国际化生成目录存放arb文件
│  |── /page/<---------------------页面
│  │── /route/<--------------------路由管理
│  │── /util/<---------------------工具类
│  └── /widget/<-------------------自定义或者通用的组件
├── pubspec.lock<------------------最终依赖版本
├── pubspec.yaml<------------------Flutter pubspec依赖以及相关配置文件
└── README.md<---------------------Readme

```

### :tipping_hand_man: 五、作者

* **Name**: smarthane
* **Email**: <459121776@qq.com>
* **Description**: Android and J2EE developer

### :thinking: 六、鸣谢&工程中使用到的框架

- :sparkle:
- [闲鱼提供的redux开发框架：fish_redux](https://github.com/alibaba/fish-redux)
- [玩安卓提供的免费接口调用：wan android](https://www.wanandroid.com/)
- [非常漂亮的一个玩安卓示例：fun_android_flutter](https://github.com/phoenixsky/fun_android_flutter)
- :skier:
- [shared_preferences](https://github.com/flutter/plugins/tree/master/packages/shared_preferences)
- [localstorage](https://github.com/lesnitsky/flutter_localstorage)
- [bot_toast](https://github.com/MMMzq/bot_toast/blob/master/README_zh.md)
- [pull_to_refresh](https://github.com/peng8350/flutter_pulltorefresh)
- [flutter_swiper](https://github.com/best-flutter/flutter_swiper/blob/master/README-ZH.md)
- [cached_network_image](https://github.com/Baseflow/flutter_cached_network_image)
- [webview_flutter](https://github.com/flutter/plugins/tree/master/packages/webview_flutter)
- [flutter_webview_plugin](https://github.com/fluttercommunity/flutter_webview_plugin)
- [url_launcher](https://pub.flutter-io.cn/packages/url_launcher)
- [install_plugin](https://github.com/hui-z/flutter_install_plugin)
- [package_info](https://github.com/flutter/plugins/tree/master/packages/package_info)
- [dio](https://github.com/flutterchina/dio)
- [dio_cookie_manager](https://github.com/flutterchina/dio/tree/master/plugins/cookie_manager)
- [cookie_jar](https://github.com/flutterchina/cookie_jar)
- [connectivity](https://github.com/flutter/plugins/tree/master/packages/connectivity)
- [permission_handler](https://github.com/baseflowit/flutter-permission-handler)
- [html_unescape](https://github.com/filiph/html_unescape)
- [flutter_html](https://github.com/Sub6Resources/flutter_html)
- [shimmer](https://github.com/hnvn/flutter_shimmer)
- [lottie](https://github.com/xvrh/lottie-flutter)
- [flutter_local_notifications](https://github.com/MaikuB/flutter_local_notifications)
- [flutter_screenutil](https://github.com/OpenFlutter/flutter_screenutil)
