import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart' hide Banner;
import 'package:flutter_starter/api/model/navigation_site_model.dart';
import 'package:flutter_starter/api/model/tree_model.dart';
import 'package:flutter_starter/common/http_manager.dart';
import 'model/article_model.dart';
import 'model/banner_model.dart';

/// @Author: smarthane
/// @GitHub: https://github.com/smarthane
/// @Description: 玩Android网络请求ApiHelper.
/// @Date: 2020/11/21

class WanandroidApiHelper {
  /// 全局网络请求 请求不同 业务平台返回的 接口类型 数据格式不一样
  /// 单独处理不同业务 请求http
  static HttpManager _http = new HttpManager("https://www.wanandroid.com/")
    ..client
        .interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) {
          // 在请求被发送之前做一些事情
          return options; //continue
          // 如果你想完成请求并返回一些自定义数据，可以返回一个`Response`对象或返回`dio.resolve(data)`。
          // 这样请求将会被终止，上层then会被调用，then中返回的数据将是你的自定义数据data.
          //
          // 如果你想终止请求并触发一个错误,你可以返回一个`DioError`对象，或返回`dio.reject(errMsg)`，
          // 这样请求将被中止并触发异常，上层catchError会被调用。
        }, onResponse: (Response response) {
          debugPrint("Flutter Starter onResponse->" + response.toString());
          // 在返回响应数据之前做一些预处理
          // 处理请求状态
          WanandroidResponse respData =
              WanandroidResponse.fromJson(response.data);
          if (respData.success) {
            response.data = respData.data;
            return _http.client.resolve(response);
          } else {
            return _handleFailed(respData);
          }
        }, onError: (DioError e) {
          // 处理异常
          // 当请求失败时做一些预处理
          debugPrint("Flutter Starter onError->" + e.toString());
          return e; //continue
        }));

  /// 需要登录时 抛异常处理
  static Future<Response> _handleFailed(WanandroidResponse respData) {
    if (respData.code == -1001) {
      // 如果cookie过期,需要清除本地存储的登录信息
      // StorageManager.localStorage.deleteItem(UserModel.keyUser);
      // 需要登录
      throw const UnAuthorizedException();
    }
    return _http.client.reject(respData.message);
  }

  /// 获取首页轮播图片
  static Future fetchBanners() async {
    try {
      var response = await _http.get('banner/json');
      return response.data
          .map<Banner>((item) => Banner.fromJsonMap(item))
          .toList();
    } catch (e) {
      // TODO
    }
  }

  /// 置顶文章
  static Future fetchTopArticles() async {
    var response = await _http.get('article/top/json');
    return response.data.map<Article>((item) => Article.fromMap(item)).toList();
  }

  /// 文章分页 获取
  static Future fetchArticles(int pageNum, {int cid}) async {
    await Future.delayed(Duration(seconds: 1));
    var response = await _http.get('article/list/$pageNum/json',
        params: (cid != null ? {'cid': cid} : null));
    return response.data['datas']
        .map<Article>((item) => Article.fromMap(item))
        .toList();
  }

  /// 项目分类
  static Future fetchTreeCategories() async {
    var response = await _http.get('tree/json');
    return response.data.map<Tree>((item) => Tree.fromJsonMap(item)).toList();
  }

  /// 体系分类
  static Future fetchProjectCategories() async {
    var response = await _http.get('project/tree/json');
    return response.data.map<Tree>((item) => Tree.fromJsonMap(item)).toList();
  }

  /// 公众号分类
  static Future fetchWechatAccounts() async {
    var response = await _http.get('wxarticle/chapters/json');
    return response.data.map<Tree>((item) => Tree.fromJsonMap(item)).toList();
  }

  /// 公众号文章
  static Future fetchWechatAccountArticles(int pageNum, int id) async {
    var response = await _http.get('wxarticle/list/$id/$pageNum/json');
    return response.data['datas']
        .map<Article>((item) => Article.fromMap(item))
        .toList();
  }

  /// 导航網址
  static Future fetchNavigationSite() async {
    var response = await _http.get('navi/json');
    return response.data
        .map<NavigationSite>((item) => NavigationSite.fromMap(item))
        .toList();
  }
}

class WanandroidResponse {
  dynamic data;
  int code = 0;
  String message;

  bool get success => 0 == code;

  WanandroidResponse({this.data, this.code, this.message});

  @override
  String toString() {
    return 'WanandroidResponse{data: $data, status: $code, message: $message}';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['errorCode'] = this.code;
    data['errorMsg'] = this.message;
    data['data'] = this.data;
    return data;
  }

  WanandroidResponse.fromJson(Map<String, dynamic> json) {
    code = json['errorCode'];
    message = json['errorMsg'];
    data = json['data'];
  }
}

/// 用于未登录等权限不够,需要跳转授权页面
class UnAuthorizedException implements Exception {
  const UnAuthorizedException();

  @override
  String toString() => 'UnAuthorizedException';
}
