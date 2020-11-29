import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_starter/app.dart';
import 'package:flutter_starter/global_store/state.dart';
import 'package:flutter_starter/global_store/store.dart';
import 'package:flutter_starter/page/article/page.dart';
import 'package:flutter_starter/page/demos/page.dart';
import 'package:flutter_starter/page/home/page.dart';
import 'package:flutter_starter/page/login/page.dart';
import 'package:flutter_starter/page/register/page.dart';
import 'package:flutter_starter/page/setting/page.dart';
import 'package:flutter_starter/page/splash/page.dart';
import 'package:flutter_starter/page/web/page.dart';

/// @Author: smarthane
/// @GitHub: https://github.com/smarthane
/// @Description: 路由管理
/// @Date: 2020/11/29

class RouteManager {
  /// 定义路由名称
  /// 启动 application
  static const String appPage = 'page/app';

  /// Webview
  static const String webViewPage = 'page/webView';

  /// Demos 开发示例
  static const String demosPage = 'page/demos';

  /// splash 启动页面
  static const String splashPage = 'page/splash';

  /// 登录页面
  static const String loginPage = 'page/login';

  /// 注册页面
  static const String registerPage = 'page/register';

  /// 首页
  static const String homePage = 'page/home';

  /// 体系--> 选择相关知识点的详情页
  static const String articlePage = 'page/article';

  /// 设置页面
  static const String settingPage = 'page/setting';

  static final AbstractRoutes routes = PageRoutes(
    pages: <String, Page<Object, dynamic>>{
      ///将路由名称和页面映射在一起
      RouteManager.appPage: AppPage(),
      RouteManager.webViewPage: WebviewPage(),
      RouteManager.demosPage: DemosPage(),
      RouteManager.splashPage: SplashPage(),
      RouteManager.loginPage: LoginPage(),
      RouteManager.registerPage: RegisterPage(),
      RouteManager.homePage: HomePage(),
      RouteManager.articlePage: ArticlePage(),
      RouteManager.settingPage: SettingPage()
    },
    visitor: (String path, Page<Object, dynamic> page) {
      ///全局状态管理
      if (page.isTypeof<GlobalBaseState>()) {
        ///建立AppStore驱动PageStore的单向数据连接
        ///参数1 AppStore
        ///参数2 当AppStore.state变化时,PageStore.state该如何变化
        page.connectExtraStore<GlobalState>(GlobalStore.store,
            (Object pageState, GlobalState appState) {
          final GlobalBaseState p = pageState;
          if (pageState is Cloneable) {
            final Object copy = pageState.clone();
            final GlobalBaseState newState = copy;

            if (p.store == null) {
              ///这地方的判断是必须的，判断第一次store对象是否为空
              newState.store = appState.store;
            } else {
              /// 这地方增加字段判断，是否需要更新
              if ((p.store.themeModel != appState.store.themeModel)) {
                newState.store.themeModel = appState.store.themeModel;
              }
              if ((p.store.localeModel != appState.store.localeModel)) {
                newState.store.localeModel = appState.store.localeModel;
              }

              /// 下列一系列对比...
            }

            /// 返回新的 state 并将数据设置到 ui
            return newState;
          }
          return pageState;
        });
      }
    },
  );
}
