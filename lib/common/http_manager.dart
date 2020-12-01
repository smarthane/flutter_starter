import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_starter/util/log_utils.dart';

/// @Author: smarthane
/// @GitHub: https://github.com/smarthane
/// @Description: 网络请求基础工具.
/// @Date: 2020/11/21

///dio Response 根据不同业务接口数据处理不同返回的数据格式
typedef ResponseParse = Future<dynamic> Function(Response<dynamic> data);

///不同业务定制自己的 http请求
///解析不同的返回json数据，配置不同的拦截机制。
class HttpManager {
  ///同一个CancelToken可以用于多个请求，当一个CancelToken取消时，
  ///所有使用该CancelToken的请求都会被取消，一个页面对应一个CancelToken。
  Map<String, CancelToken> _cancelTokens = Map<String, CancelToken>();

  /// http request methods
  static const String GET = 'get';
  static const String POST = 'post';

  /// 连接超时时间为10秒
  int _connectTimeOut = 10 * 1000;

  /// 响应超时时间为15秒
  int _receiveTimeOut = 15 * 1000;

  /// Dio
  Dio _client;

  /// Dio client
  Dio get client => _client;

  /// 据不同业务接口数据处理不同返回的数据格式
  ResponseParse _responseParse;

  HttpManager(
      {@required baseUrl,
      bool isDebug = true,
      BaseOptions baseOptions,
      ResponseParse responseParse}) {
    BaseOptions options = baseOptions ?? _defaultOptions(baseUrl);
    _client = DioForNative(options);
    _responseParse = responseParse;
    if (isDebug) {
      /// 打印请求日志
      _client.interceptors.add(LogInterceptor(
        responseBody: true,
        requestHeader: false,
        responseHeader: false,
        request: true,
        requestBody: true,
      ));
    }
  }

  /// 默认的基础选项配置
  BaseOptions _defaultOptions(baseUrl) {
    return BaseOptions(
      /// 请求基地址,可以包含子路径
      baseUrl: baseUrl,

      /// 连接服务器超时时间，单位是毫秒.
      connectTimeout: _connectTimeOut,

      /// 响应流上前后两次接受到数据的间隔，单位为毫秒。
      receiveTimeout: _receiveTimeOut,

      /// Http请求头.
      headers: {
        'platform': Platform.operatingSystem,
        'accept-language': 'zh-cn',
        'content-type': 'application/json',
      },

      /// 请求的Content-Type，默认值是"application/json; charset=utf-8",Headers.formUrlEncodedContentType会自动编码请求体.
      contentType: Headers.formUrlEncodedContentType,

      /// 表示期望以那种格式(方式)接受响应数据。接受四种类型 `json`, `stream`, `plain`, `bytes`. 默认值是 `json`,
      responseType: ResponseType.json,
    );
  }

  ///GET异步网络请求
  ///
  ///[url] 网络请求地址不包含域名
  ///[params] url请求参数支持restful
  ///[options] 请求配置
  Future get({
    @required String url,
    Map<String, dynamic> params,
    Options options,
  }) async {
    return _requestAsync(
      url: url,
      method: GET,
      params: params,
      options: options,
      tag: "tag_$url",
    );
  }

  ///GET异步网络请求
  ///
  ///[url] 网络请求地址不包含域名
  ///[params] url请求参数支持restful
  ///[options] 请求配置
  ///[tag] 请求统一标识，用于取消网络请求
  Future getAsync({
    @required String url,
    Map<String, dynamic> params,
    Options options,
    @required String tag,
  }) async {
    return _requestAsync(
      url: url,
      method: GET,
      params: params,
      options: options,
      tag: tag,
    );
  }

  ///POST 异步网络请求
  ///
  ///[url] 网络请求地址不包含域名
  ///[data] post 请求参数
  ///[params] url请求参数支持restful
  ///[options] 请求配置
  ///[tag] 请求统一标识，用于取消网络请求
  Future post({
    @required String url,
    data,
    Map<String, dynamic> params,
    Options options,
  }) async {
    return _requestAsync(
      url: url,
      method: POST,
      data: data,
      params: params,
      options: options,
      tag: "tag_$url",
    );
  }

  ///POST 异步网络请求
  ///
  ///[url] 网络请求地址不包含域名
  ///[data] post 请求参数
  ///[params] url请求参数支持restful
  ///[options] 请求配置
  ///[tag] 请求统一标识，用于取消网络请求
  Future postAsync({
    @required String url,
    data,
    Map<String, dynamic> params,
    Options options,
    @required String tag,
  }) async {
    return _requestAsync(
      url: url,
      method: POST,
      data: data,
      params: params,
      options: options,
      tag: tag,
    );
  }

  ///统一网络请求
  ///
  ///[url] 网络请求地址不包含域名
  ///[data] post 请求参数
  ///[params] url请求参数支持restful
  ///[options] 请求配置
  ///[tag] 请求统一标识，用于取消网络请求
  Future _requestAsync({
    @required String url,
    String method,
    data,
    Map<String, dynamic> params,
    Options options,
    @required String tag,
  }) async {
    try {
      ///检查网络是否连接
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.none) {
        LogUtils.v("请求网络异常，请稍后重试！");
        throw new HttpError(HttpError.CODE_NETWORK_ERROR, "网络异常，请稍后重试！");
      }

      ///设置默认值
      params = params ?? {};
      method = method ?? 'GET';
      options?.method = method;
      options = options ??
          Options(
            method: method,
          );
      url = _restfulUrl(url, params);
      CancelToken cancelToken;
      if (tag != null) {
        cancelToken =
            _cancelTokens[tag] == null ? CancelToken() : _cancelTokens[tag];
        _cancelTokens[tag] = cancelToken;
      }
      Response response = await _client.request(url,
          queryParameters: params,
          data: data,
          options: options,
          cancelToken: cancelToken);

      /// ///////////////////////////////////////////////////////////////////////
      if (_responseParse != null) {
        return _responseParse(response);
      } else {
        return response;
      }

      /// ///////////////////////////////////////////////////////////////////////
    } on DioError catch (e, s) {
      LogUtils.v("请求出错：$e\n$s");
      throw new HttpError.dioError(e);
    } catch (e, s) {
      LogUtils.v("未知异常出错：$e\n$s");
      throw new HttpError(HttpError.CODE_UNKNOWN, "网络异常，请稍后重试！");
    }
  }

  ///异步下载文件
  ///
  ///[url] 下载地址
  ///[savePath]  文件保存路径
  ///[onReceiveProgress]  文件保存路径
  ///[data] post 请求参数
  ///[params] url请求参数支持restful
  ///[options] 请求配置
  Future<Response> download({
    @required String url,
    @required savePath,
    ProgressCallback onReceiveProgress,
    Map<String, dynamic> params,
    data,
    Options options,
  }) async {
    return downloadAsync(
        url: url,
        savePath: savePath,
        onReceiveProgress: onReceiveProgress,
        params: params,
        data: data,
        options: options,
        tag: "tag_$url");
  }

  ///异步下载文件
  ///
  ///[url] 下载地址
  ///[savePath]  文件保存路径
  ///[onReceiveProgress]  文件保存路径
  ///[data] post 请求参数
  ///[params] url请求参数支持restful
  ///[options] 请求配置
  ///[tag] 请求统一标识，用于取消网络请求
  Future<Response> downloadAsync({
    @required String url,
    @required savePath,
    ProgressCallback onReceiveProgress,
    Map<String, dynamic> params,
    data,
    Options options,
    @required String tag,
  }) async {
    try {
      /// 检查网络是否连接
      ConnectivityResult connectivityResult =
          await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.none) {
        LogUtils.v("请求网络异常，请稍后重试！");
        throw (HttpError(HttpError.CODE_NETWORK_ERROR, "网络异常，请稍后重试！"));
      }

      /// 设置下载不超时
      int receiveTimeout = 0;
      options ??= options == null
          ? Options(receiveTimeout: receiveTimeout)
          : options.merge(receiveTimeout: receiveTimeout);

      /// 设置默认值
      params = params ?? {};

      url = _restfulUrl(url, params);

      CancelToken cancelToken;
      if (tag != null) {
        cancelToken =
            _cancelTokens[tag] == null ? CancelToken() : _cancelTokens[tag];
        _cancelTokens[tag] = cancelToken;
      }

      return _client.download(url, savePath,
          onReceiveProgress: onReceiveProgress,
          queryParameters: params,
          data: data,
          options: options,
          cancelToken: cancelToken);
    } on DioError catch (e, s) {
      LogUtils.v("请求出错：$e\n$s");
      throw (HttpError.dioError(e));
    } catch (e, s) {
      LogUtils.v("未知异常出错：$e\n$s");
      throw (HttpError(HttpError.CODE_UNKNOWN, "网络异常，请稍后重试！"));
    }
  }

  ///上传文件
  ///
  ///[url] 网络请求地址不包含域名
  ///[data] post 请求参数
  ///[onSendProgress] 上传进度
  ///[params] url请求参数支持restful
  ///[options] 请求配置
  Future upload({
    @required String url,
    FormData data,
    ProgressCallback onSendProgress,
    Map<String, dynamic> params,
    Options options,
  }) async {
    return uploadAsync(
        url: url,
        data: data,
        onSendProgress: onSendProgress,
        params: params,
        options: options,
        tag: "tag_$url");
  }

  ///上传文件
  ///
  ///[url] 网络请求地址不包含域名
  ///[data] post 请求参数
  ///[onSendProgress] 上传进度
  ///[params] url请求参数支持restful
  ///[options] 请求配置
  ///[tag] 请求统一标识，用于取消网络请求
  Future uploadAsync({
    @required String url,
    FormData data,
    ProgressCallback onSendProgress,
    Map<String, dynamic> params,
    Options options,
    @required String tag,
  }) async {
    try {
      /// 检查网络是否连接
      ConnectivityResult connectivityResult =
          await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.none) {
        LogUtils.v("请求网络异常，请稍后重试！");
        throw (HttpError(HttpError.CODE_NETWORK_ERROR, "网络异常，请稍后重试！"));
      }

      /// 设置默认值
      params = params ?? {};

      /// 强制 POST 请求
      options?.method = POST;
      options = options ??
          Options(
            method: POST,
          );
      url = _restfulUrl(url, params);
      CancelToken cancelToken;
      if (tag != null) {
        cancelToken =
            _cancelTokens[tag] == null ? CancelToken() : _cancelTokens[tag];
        _cancelTokens[tag] = cancelToken;
      }
      Response<Map<String, dynamic>> response = await _client.request(url,
          onSendProgress: onSendProgress,
          data: data,
          queryParameters: params,
          options: options,
          cancelToken: cancelToken);

      /// ///////////////////////////////////////////////////////////////////////
      if (_responseParse != null) {
        return _responseParse(response);
      } else {
        return response;
      }

      /// ///////////////////////////////////////////////////////////////////////
    } on DioError catch (e, s) {
      LogUtils.v("请求出错：$e\n$s");
      throw (HttpError.dioError(e));
    } catch (e, s) {
      LogUtils.v("未知异常出错：$e\n$s");
      throw (HttpError(HttpError.CODE_UNKNOWN, "网络异常，请稍后重试！"));
    }
  }

  ///  取消网络请求
  void cancel(String tag) {
    if (_cancelTokens.containsKey(tag)) {
      if (!_cancelTokens[tag].isCancelled) {
        _cancelTokens[tag].cancel();
      }
      _cancelTokens.remove(tag);
    }
  }

  ///restful处理
  String _restfulUrl(String url, Map<String, dynamic> params) {
    // restful 请求处理
    // /gysw/search/hist/:user_id        user_id=27
    // 最终生成 url 为     /gysw/search/hist/27
    params.forEach((key, value) {
      if (url.indexOf(key) != -1) {
        url = url.replaceAll(':$key', value.toString());
      }
    });
    return url;
  }
}

/// ///////////////////////////////////////////////////////////////////
/// 数据加载时 页面状态控制
/// ///////////////////////////////////////////////////////////////////
/// 请求状态类型
enum RequestState {
  start, //开始
  load, //开始加载数据
  empty, //无数据空列表
  success, //加载成功
  error, //加载失败
}

class ViewStateModel {
  RequestState requestState = RequestState.start;

  bool get isLoad => requestState == RequestState.load;

  bool get isEmpty => requestState == RequestState.empty;

  bool get isError => requestState == RequestState.error;

  bool get isSuccess => requestState == RequestState.success;

  bool get isStart => requestState == RequestState.start;

  void setStart() {
    requestState = RequestState.start;
  }

  void setError() {
    requestState = RequestState.error;
  }

  void setLoad() {
    requestState = RequestState.load;
  }

  void setEmpty() {
    requestState = RequestState.empty;
  }

  void setSuccess() {
    requestState = RequestState.success;
  }

  ViewStateModel({this.requestState});
}
/// ///////////////////////////////////////////////////////////////////
/// 网络请求错误 定义
/// ///////////////////////////////////////////////////////////////////
class HttpError implements Exception {
  ///HTTP 状态码
  static const int UNAUTHORIZED = 401;
  static const int FORBIDDEN = 403;
  static const int NOT_FOUND = 404;
  static const int REQUEST_TIMEOUT = 408;
  static const int INTERNAL_SERVER_ERROR = 500;
  static const int BAD_GATEWAY = 502;
  static const int SERVICE_UNAVAILABLE = 503;
  static const int GATEWAY_TIMEOUT = 504;

  ///未知错误
  static const int CODE_UNKNOWN = -100;

  ///解析错误
  static const int CODE_PARSE_ERROR = -101;

  ///网络错误
  static const int CODE_NETWORK_ERROR = -102;

  ///协议错误
  static const int CODE_HTTP_ERROR = -103;

  ///证书错误
  static const int CODE_SSL_ERROR = -104;

  ///连接超时
  static const int CODE_CONNECT_TIMEOUT = -105;

  ///响应超时
  static const int CODE_RECEIVE_TIMEOUT = -106;

  ///发送超时
  static const int CODE_SEND_TIMEOUT = -107;

  ///网络请求取消
  static const int CODE_CANCEL = -108;

  ///未授权
  static const int CODE_UNAUTHORIZEDL = -109;

  int code;

  String message;

  HttpError(this.code, this.message);

  HttpError.dioError(DioError error) {
    message = error.message;
    switch (error.type) {
      case DioErrorType.CONNECT_TIMEOUT:
        code = CODE_CONNECT_TIMEOUT;
        message = "网络连接超时，请检查网络设置";
        break;
      case DioErrorType.RECEIVE_TIMEOUT:
        code = CODE_RECEIVE_TIMEOUT;
        message = "服务器异常，请稍后重试！";
        break;
      case DioErrorType.SEND_TIMEOUT:
        code = CODE_SEND_TIMEOUT;
        message = "网络连接超时，请检查网络设置";
        break;
      case DioErrorType.RESPONSE:
        code = CODE_HTTP_ERROR;
        message = "服务器异常，请稍后重试！";
        break;
      case DioErrorType.CANCEL:
        code = CODE_CANCEL;
        message = "请求已被取消，请重新请求";
        break;
      case DioErrorType.DEFAULT:
        code = CODE_UNKNOWN;
        message = "网络异常，请稍后重试！";
        break;
    }
  }

  @override
  String toString() {
    return 'HttpError{code: $code, message: $message}';
  }
}
