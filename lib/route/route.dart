import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action, Page;
import 'package:flutter_starter/app.dart';
import 'package:flutter_starter/global_store/state.dart';
import 'package:flutter_starter/global_store/store.dart';
import 'package:flutter_starter/page/aboutme/page.dart';
import 'package:flutter_starter/page/article/page.dart';
import 'package:flutter_starter/page/demos/base_components/page.dart';
import 'package:flutter_starter/page/demos/bot_toast/page.dart';
import 'package:flutter_starter/page/demos/city_pickers/page.dart';
import 'package:flutter_starter/page/demos/image_pickers/page.dart';
import 'package:flutter_starter/page/demos/page.dart';
import 'package:flutter_starter/page/demos/staggered/page.dart';
import 'package:flutter_starter/page/feedback/page.dart';
import 'package:flutter_starter/page/home/page.dart';
import 'package:flutter_starter/page/login/page.dart';
import 'package:flutter_starter/page/register/page.dart';
import 'package:flutter_starter/page/setting/page.dart';
import 'package:flutter_starter/page/splash/page.dart';
import 'package:flutter_starter/page/web/page.dart';
import 'package:flutter_starter/util/log_utils.dart';

/// @Author: smarthane
/// @GitHub: https://github.com/smarthane
/// @Description: 路由管理 AOP middleware 页面生命周期
/// @Date: 2020/11/29

class RouteManager {
  /// 0.定义路由名称
  /// 启动 application
  static const String appPage = 'page/app';
  /// /////////////////////////////////////////////////////////////////////
  /// Webview
  static const String webViewPage = 'page/webView';

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
  /// 设置页面 意见反馈
  static const String feedbackPage = 'page/setting/feedback';
  /// 设置页面 关于我
  static const String aboutMePage = 'page/setting/aboutme';
  /// /////////////////////////////////////////////////////////////////////
  /// Demos 开发示例
  static const String demosPage = 'page/demos';
  /// Demos 开发示例 瀑布流
  static const String demoStaggeredPage = 'page/demo/staggered';
  /// Demos 开发示例 Toast
  static const String demoToastPage = 'page/demo/toast';
  /// Demos 开发示例 城市选择
  static const String demoCityPickersPage = 'page/demo/citypickers';
  /// Demos 开发示例 图片选择器
  static const String demoImagePickersPage = 'page/demo/imagepickers';
  /// Demos 开发示例 基础组件
  static const String demoBaseComponentsPage = 'page/demo/basecomponents';
  /// /////////////////////////////////////////////////////////////////////

  /// 路由配置
  static final AbstractRoutes routes = PageRoutes(
    pages: <String, Page<Object, dynamic>>{
      /// /////////////////////////////////////////////////////////////////////
      ///将路由名称和页面映射在一起
      RouteManager.appPage: AppPage(),
      RouteManager.webViewPage: WebviewPage(),
      RouteManager.splashPage: SplashPage(),
      RouteManager.loginPage: LoginPage(),
      RouteManager.registerPage: RegisterPage(),
      RouteManager.homePage: HomePage(),
      RouteManager.articlePage: ArticlePage(),
      RouteManager.settingPage: SettingPage(),
      RouteManager.feedbackPage: FeedbackPage(),
      RouteManager.aboutMePage: AboutMePage(),
      ///常用开发示例代码
      RouteManager.demosPage: DemosPage(),
      RouteManager.demoStaggeredPage: StaggeredPage(),
      RouteManager.demoToastPage: BotToastPage(),
      RouteManager.demoCityPickersPage: CityPickersPage(),
      RouteManager.demoImagePickersPage: ImagePickersPage(),
      RouteManager.demoBaseComponentsPage: BaseComponentsPage(),
      /// /////////////////////////////////////////////////////////////////////
    },
    visitor: (String path, Page<Object, dynamic> page) {
      /// 1.全局状态管理
      /// 只有特定的范围的 Page 才需要建立和 AppStore 的连接关系
      /// 满足 Page<T> ，T 是 GlobalBaseState 的子类
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
              if ((p.store.userModel != appState.store.userModel)) {
                newState.store.userModel = appState.store.userModel;
              }

              /// 下列一系列对比...
            }

            /// 返回新的 state 并将数据设置到 ui
            return newState;
          }
          return pageState;
        });
      }

      /// 2.AOP
      /// 页面可以有一些私有的 AOP 的增强， 但往往会有一些 AOP 是整个应用下，所有页面都会有的。
      /// 这些公共的通用 AOP ，通过遍历路由页面的形式统一加入。
      page.enhancer.append(
        /// View AOP
        viewMiddleware: <ViewMiddleware<dynamic>>[
          safetyView<dynamic>(),
        ],

        /// Adapter AOP
        adapterMiddleware: <AdapterMiddleware<dynamic>>[
          safetyAdapter<dynamic>()
        ],

        /// Effect AOP
        effectMiddleware: <EffectMiddleware<dynamic>>[
          _pageAnalyticsMiddleware<dynamic>(),
        ],

        /// Store AOP
        middleware: <Middleware<dynamic>>[
          logMiddleware<dynamic>(tag: page.runtimeType.toString()),
        ],
      );
    },
  );

  /// 打开webview
  static void openWebViewPage({@required String url, String title = ""}) {
    FsNavigatorObserver.fsNavigator.pushNamed(RouteManager.webViewPage,
        arguments: {"title": title, "url": url});
  }
}

/// 简单的 Effect AOP
/// 只针对页面的生命周期进行打印
EffectMiddleware<T> _pageAnalyticsMiddleware<T>({String tag = 'fish redux --> '}) {
  return (AbstractLogic<dynamic> logic, Store<T> store) {
    return (Effect<dynamic> effect) {
      return (Action action, Context<dynamic> ctx) {
        if (logic is Page<dynamic, dynamic> && action.type is Lifecycle) {
          /// 页面的生命周期
          LogUtils.v('${logic.runtimeType} ${action.type.toString()} ', tag: tag);
        }
        return effect?.call(action, ctx);
      };
    };
  };
}

/// Navigatior 页面跳转
/// 通过这种方式不用传context也可以进行页面跳转 如做一个全局拦截的页面跳转
/// 推送等相关页面
/// 调用示例：FsNavigatorObserver.fsNavigator.pushNamed(RouteManager.loginPage);
class FsNavigatorObserver extends NavigatorObserver {
  FsNavigatorObserver._();

  static FsNavigatorObserver _instance;

  static FsNavigatorObserver get instance {
    if (_instance == null) {
      _instance = FsNavigatorObserver._();
    }

    return _instance;
  }

  static OverlayState get fsOverlay {
    return FsNavigatorObserver.instance.navigator.overlay;
  }

  static NavigatorState get fsNavigator {
    return FsNavigatorObserver.instance.navigator;
  }

  factory FsNavigatorObserver() => instance;
}