import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';
import 'package:flutter/foundation.dart';

/// @Author: smarthane
/// @GitHub: https://github.com/smarthane
/// @Description: 网络请求基础工具.
/// @Date: 2020/11/21

class HttpManager {
  /// 连接超时时间为10秒
  int _connectTimeOut = 10 * 1000;

  /// 响应超时时间为15秒
  int _receiveTimeOut = 15 * 1000;

  /// Dio
  Dio _client;

  HttpManager(baseUrl, {isDebug = true}) {
    BaseOptions options = BaseOptions(
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
    _client = DioForNative(options);
    //_client.transformer = DefaultTransformer(jsonDecodeCallback: _parseJson);
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

  Dio get client => _client;

  set setConnectTimeOut(int connectTimeOut) {
    this._connectTimeOut = connectTimeOut;
  }

  set setReceiveTimeOut(int receiveTimeOut) {
    this._receiveTimeOut = receiveTimeOut;
  }

  // 必须是顶层函数
  _parseAndDecode(String response) {
    return jsonDecode(response);
  }

  _parseJson(String text) {
    return compute(_parseAndDecode, text);
  }

  Future get(String url, {Map<String, dynamic> params}) {
    return _client.get(url, queryParameters: params == null ? {} : params);
  }

  Future post(String url, {Map<String, dynamic> params}) {
    return _client.post(url, data: params == null ? {} : params);
  }

  Future downloadFile(String url, String savePath,
      {ProgressCallback onReceiveProgress, Map<String, dynamic> params}) {
    return _client.download(url, savePath,
        data: params == null ? {} : params,
        onReceiveProgress: onReceiveProgress);
  }
}

/// ///////////////////////////////////////////////////////////////////
///
///
/// ///////////////////////////////////////////////////////////////////

/// 请求状态类型
enum RequestState {
  start, //开始
  load, //开始加载数据
  empty, //无数据空列表
  success, //加载成功
  error, //加载失败
}

abstract class ViewStateModel {
  RequestState requestState = RequestState.start;

  bool get isLoad => requestState == RequestState.load;

  bool get isEmpty => requestState == RequestState.empty;

  bool get isError => requestState == RequestState.error;

  bool get isSuccess => requestState == RequestState.success;

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
}
