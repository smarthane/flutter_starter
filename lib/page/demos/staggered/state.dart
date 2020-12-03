import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_starter/global_store/state.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// @Author: smarthane
/// @GitHub: https://github.com/smarthane
/// @Description:
/// @Date: 2020/11/29

class StaggeredState implements Cloneable<StaggeredState>, GlobalBaseState {
  List<StaggeredItemData> itemList;
  RefreshController refreshController;

  @override
  StaggeredState clone() {
    return StaggeredState()
      ..store = store
      ..itemList = itemList
      ..refreshController = refreshController;
  }

  @override
  StoreModel store;
}

StaggeredState initState(Map<String, dynamic> args) {
  return StaggeredState()
    ..itemList = _initItemList()
    ..refreshController = new RefreshController(initialRefresh: true);
}

class StaggeredItemData {
  /// 图片地址
  String imageUrl;

  /// 名称
  String name;

  StaggeredItemData({this.imageUrl, this.name});
}

List<StaggeredItemData> _initItemList() {
  List<StaggeredItemData> itemList = List();

  itemList.add(StaggeredItemData(
      imageUrl:
          "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1606976762455&di=cad7e566ac410e709c5fdbd142b3908d&imgtype=0&src=http%3A%2F%2Fattach.bbs.miui.com%2Fforum%2F201303%2F16%2F173710lvx470i4348z6i6z.jpg",
      name: "我是瀑布流标题"));

  itemList.add(StaggeredItemData(
      imageUrl:
          "https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=3673687039,3023524618&fm=26&gp=0.jpg",
      name: "我是瀑布流标题"));

  itemList.add(StaggeredItemData(
      imageUrl:
          "https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=1371785353,1160451941&fm=26&gp=0.jpg",
      name: "我是瀑布流标题"));

  itemList.add(StaggeredItemData(
      imageUrl:
          "https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=1874831330,3373343559&fm=26&gp=0.jpg",
      name: "我是瀑布流标题"));

  itemList.add(StaggeredItemData(
      imageUrl:
          "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1606983650182&di=6eb3b4c0841c31007921df4b85fa093d&imgtype=0&src=http%3A%2F%2Fpic35.photophoto.cn%2F20150502%2F0017029543798637_b.jpg",
      name: "我是瀑布流标题"));

  itemList.add(StaggeredItemData(
      imageUrl:
          "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1606983682360&di=6e6ba44069534f27fc7a4f0d5128f4b7&imgtype=0&src=http%3A%2F%2Fpic23.nipic.com%2F20120905%2F2548530_155938714193_2.jpg",
      name: "我是瀑布流标题"));
  itemList.add(StaggeredItemData(
      imageUrl:
          "https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=3740891955,4260360647&fm=26&gp=0.jpg",
      name: "我是瀑布流标题"));

  itemList.add(StaggeredItemData(
      imageUrl:
          "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1606983857185&di=0ab24697849976d4b46fa28cc36e7e2d&imgtype=0&src=http%3A%2F%2Fpic21.nipic.com%2F20120609%2F4223960_153811146116_2.jpg",
      name: "我是瀑布流标题"));

  itemList.add(StaggeredItemData(
      imageUrl:
          "https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=2561519603,1430553343&fm=26&gp=0.jpg",
      name: "我是瀑布流标题"));

  itemList.add(StaggeredItemData(
      imageUrl:
          "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1606995356725&di=03447928939d15e4de6482d509d72c69&imgtype=0&src=http%3A%2F%2F5b0988e595225.cdn.sohucs.com%2Fq_70%2Cc_zoom%2Cw_640%2Fimages%2F20190308%2Fb749d5188dd84da599a70fd82945876c.jpg",
      name: "我是瀑布流标题"));

  itemList.add(StaggeredItemData(
      imageUrl:
          "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1606995393050&di=c1fe7f02d2855778633b0df2b43a13bc&imgtype=0&src=http%3A%2F%2Fimage.mamicode.com%2Finfo%2F201812%2F20181217124822110209.png",
      name: "我是瀑布流标题"));

  itemList.add(StaggeredItemData(
      imageUrl:
          "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1606995527009&di=e08c4a96990c9c689fadce3f14d831ca&imgtype=0&src=http%3A%2F%2F5b0988e595225.cdn.sohucs.com%2Fimages%2F20190617%2Fd402dc14049d442bb95b91ff33034c7d.jpeg",
      name: "我是瀑布流标题"));

  itemList.add(StaggeredItemData(
      imageUrl:
          "https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=2183121873,1695093187&fm=26&gp=0.jpg",
      name: "我是瀑布流标题"));
  return itemList;
}
