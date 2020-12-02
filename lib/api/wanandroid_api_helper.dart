import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter_starter/common/http_manager.dart';
import 'package:flutter_starter/common/storage_manager.dart';
import 'package:flutter_starter/util/toast_utils.dart';
import 'package:meta/meta.dart';

/// @Author: smarthane
/// @GitHub: https://github.com/smarthane
/// @Description: 玩Android网络请求ApiHelper.
/// @Date: 2020/11/21

class WanandroidApiHelper {
  /// 全局网络请求 请求不同 业务平台返回的 接口类型 数据格式不一样
  /// 单独处理不同业务 请求http
  static HttpManager _http = new HttpManager(
    baseUrl: "https://www.wanandroid.com/",
    responseParse: _parseResponse,
  )
    /// 这边可以根据项目具体的业务逻辑可以做一些请求拦截过虑等
    /// cookie持久化 异步
    ..client.interceptors.add(CookieManager(
        PersistCookieJar(dir: StorageManager.temporaryDirectory.path)));

  /// 解析http请求返回的数据
  static Future<WanandroidResponse> _parseResponse(Response response) {
    WanandroidResponse respData = WanandroidResponse.fromJson(response.data);
    /// 此处可以根据具体项目 接口返回逻辑 可以全局的做一些拦截校验 抛异常或者跳转到页面
    /// eg: throw HttpError or FsNavigatorObserver.fsNavigator
    /// 需要登录时 抛异常处理
    if (respData.code == -1001) {
      /// 用于未登录等权限不够,需要跳转授权页面
      throw HttpError(HttpError.CODE_UNAUTHORIZEDL, "未登录等权限不够");
    }
    return Future.value(respData);
  }

  /// 统一包装 网络请求异常的返回
  static Future _handlerError(HttpError httpError) {
    ToastUtils.showText(httpError.toString());
    return Future.value(WanandroidResponse(
        data: [], code: httpError.code, message: httpError.message));
  }

  /// 登录
  /// [Http._init] 添加了拦截器 设置了自动cookie.
  static Future login(String username, String password) async {
    try {
      return await _http.post(url: 'user/login', params: {
        'username': username,
        'password': password,
      });
    } on HttpError catch (e) {
      return _handlerError(e);
    }
  }

  /// 注册
  static Future register(
      String username, String password, String rePassword) async {
    try {
      return await _http.post(url: 'user/register', params: {
        'username': username,
        'password': password,
        'repassword': rePassword,
      });
    } on HttpError catch (e) {
      return _handlerError(e);
    }
  }

  /// 登出
  static Future logout() async {
    /// 自动移除cookie
    try {
      return await _http.get(url: 'user/logout/json');
    } on HttpError catch (e) {
      return _handlerError(e);
    }
  }

  /// 获取首页轮播图片
  static Future fetchBanners() async {
    try {
      return await _http.get(url: 'banner/json');
    } on HttpError catch (e) {
      return _handlerError(e);
    }
  }

  /// 置顶文章
  static Future fetchTopArticles() async {
    try {
      return await _http.get(url: 'article/top/json');
    } on HttpError catch (e) {
      return _handlerError(e);
    }
  }

  /// 文章分页 获取
  static Future fetchArticles(int pageNum, {int cid}) async {
    try {
      return await _http.get(
          url: 'article/list/$pageNum/json',
          params: (cid != null ? {'cid': cid} : null));
    } on HttpError catch (e) {
      return _handlerError(e);
    }
  }

  /// 项目分类
  static Future fetchTreeCategories() async {
    try {
      return await _http.get(url: 'tree/json');
    } on HttpError catch (e) {
      return _handlerError(e);
    }
  }

  /// 体系分类
  static Future fetchProjectCategories() async {
    try {
      return await _http.get(url: 'project/tree/json');
    } on HttpError catch (e) {
      return _handlerError(e);
    }
  }

  /// 公众号分类
  static Future fetchWechatAccounts() async {
    try {
      return await _http.get(url: 'wxarticle/chapters/json');
    } on HttpError catch (e) {
      return _handlerError(e);
    }
  }

  /// 公众号文章
  static Future fetchWechatAccountArticles(int pageNum, int id) async {
    try {
      return await _http.get(url: 'wxarticle/list/$id/$pageNum/json');
    } on HttpError catch (e) {
      return _handlerError(e);
    }
  }

  /// 导航網址
  static Future fetchNavigationSite() async {
    try {
      return await _http.get(url: 'navi/json');
    } on HttpError catch (e) {
      return _handlerError(e);
    }
  }

  /// 下载文件
  static Future downloadFile({
    @required String url,
    @required savePath,
    ProgressCallback onReceiveProgress,
    Map<String, dynamic> params,
    data,
    Options options,
  }) async {
    try {
      return await _http.download(
          url: url,
          savePath: savePath,
          onReceiveProgress: onReceiveProgress,
          params: params,
          data: data,
          options: options);
    } on HttpError catch (e) {
      return _handlerError(e);
    }
  }

  /// 下载文件
  static Future uploadFile({
    @required String url,
    FormData data,
    ProgressCallback onSendProgress,
    Map<String, dynamic> params,
    Options options,
  }) async {
    try {
      return await _http.upload(
          url: url,
          onSendProgress: onSendProgress,
          params: params,
          data: data,
          options: options);
    } on HttpError catch (e) {
      return _handlerError(e);
    }
  }
}

class WanandroidResponse {
  static const int SUCCESS_CODE = 0;

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
