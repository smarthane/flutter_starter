import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_starter/common/resource_mananger.dart';
import 'package:flutter_starter/global_store/state.dart';
import 'package:flutter_starter/route/route.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// @Author: smarthane
/// @GitHub: https://github.com/smarthane
/// @Description:
/// @Date: 2020/11/29

class DemosState implements Cloneable<DemosState>, GlobalBaseState {
  List<DemoItemModel> itemList;

  RefreshController refreshController;

  @override
  DemosState clone() {
    return DemosState()
      ..store = store
      ..itemList = itemList
      ..refreshController = refreshController;
  }

  @override
  StoreModel store;
}

DemosState initState(Map<String, dynamic> args) {
  return DemosState()
    ..itemList = _initDemoList()
    ..refreshController = new RefreshController(initialRefresh: false);
}

/// 页面数据模型
class DemoItemModel {
  /// 图片地址
  String imageUrl;

  /// 主标题
  String title;

  /// 副标题
  String subTitle;

  /// 页面路由
  String pageRoute;

  DemoItemModel({this.imageUrl, this.title, this.subTitle, this.pageRoute});
}

/// 初始化Demo列表数据
List<DemoItemModel> _initDemoList() {
  List<DemoItemModel> itemList = List();

  itemList.add(DemoItemModel(
      imageUrl:ResourceHelper.wrapAssets("demo_bottoast_icon.png"),
      title: "基础组件",
      subTitle: "Flutter Widgets",
      pageRoute: RouteManager.demoBaseComponentsPage));

  itemList.add(DemoItemModel(
      imageUrl:ResourceHelper.wrapAssets("demo_bottoast_icon.png"),
      title: "Toast",
      subTitle: "Bot Toast",
      pageRoute: RouteManager.demoToastPage));

  itemList.add(DemoItemModel(
      imageUrl:ResourceHelper.wrapAssets("demo_bottoast_icon.png"),
      title: "SQLite",
      subTitle: "SQLite operate",
      pageRoute: RouteManager.demoSqlitePage));

  itemList.add(DemoItemModel(
      imageUrl:ResourceHelper.wrapAssets("demo_citypicker_icon.png"),
      title: "城市选择",
      subTitle: "City Pickers",
      pageRoute: RouteManager.demoCityPickersPage));

  itemList.add(DemoItemModel(
      imageUrl:ResourceHelper.wrapAssets("demo_imagepicker_icon.png"),
      title: "图片选择",
      subTitle: "Image Picker",
      pageRoute: RouteManager.demoImagePickersPage));

  itemList.add(DemoItemModel(
      imageUrl:ResourceHelper.wrapAssets("demo_staggered_icon.png"),
      title: "瀑布流",
      subTitle: "Staggered",
      pageRoute: RouteManager.demoStaggeredPage));

  return itemList;
}
