import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../utils/app_config.dart';

class ApiService {
  Dio _dio = Dio();
  String tag = "API call :";
  CancelToken? _cancelToken;
  static final Dio mDio = Dio();

  static final ApiService _instance = ApiService._internal();

  factory ApiService({bool stripeAuth = false}) {
    // mDio.options.headers['Authorization'] =
    //     "Bearer ${getString(userAccessToken)}";
    mDio.options.headers['Accept-Version'] = "v1";
    mDio.options.headers['Accept-Language'] = "en";
    return _instance;
  }

  ApiService._internal() {
    _dio = initApiServiceDio();
  }

  Dio initApiServiceDio() {
    _cancelToken = CancelToken();
    final baseOption = BaseOptions(
      connectTimeout: 120 * 1000,
      receiveTimeout: 120 * 1000,
      baseUrl: apiBaseUrl,
      contentType: 'application/json',
      headers: {
        // 'Authorization': "Bearer ${getString(userAccessToken)}",
        'Accept-Version': "v1",
        'Accept-Language': "en",
      },
    );
    mDio.options = baseOption;
    final mInterceptorsWrapper = InterceptorsWrapper(
      onRequest: (options, handler) {
        debugPrint("$tag headers ${options.headers.toString()}",
            wrapWidth: 1024);
        debugPrint("$tag ${options.baseUrl.toString() + options.path}",
            wrapWidth: 1024);
        debugPrint("$tag queryParameters ${options.queryParameters.toString()}",
            wrapWidth: 1024);
        debugPrint("$tag ${options.data.toString()}", wrapWidth: 1024);
        return handler.next(options);
      },
      onResponse: (e, handler) {
        debugPrint("Code  ${e.statusCode.toString()}", wrapWidth: 1024);
        debugPrint("Response ${e.toString()}", wrapWidth: 1024);
        return handler.next(e);
      },
      onError: (e, handler) {
        debugPrint("$tag ${e.error.toString()}", wrapWidth: 1024);
        debugPrint("$tag ${e.response.toString()}", wrapWidth: 1024);
        return handler.next(e);
      },
    );
    mDio.interceptors.add(mInterceptorsWrapper);
    return mDio;
  }

  void cancelRequests({CancelToken? cancelToken}) {
    cancelToken == null
        ? _cancelToken!.cancel('Cancelled')
        : cancelToken.cancel();
  }

  Future<Response> get(
    BuildContext context,
    String endUrl, {
    Map<String, dynamic>? params,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    return await (_dio.get(
      endUrl,
      queryParameters: params,
      cancelToken: cancelToken ?? _cancelToken,
      options: options,
    ));
  }

  Future<Response> put(
    BuildContext context,
    String endUrl, {
    FormData? data,
    Map<String, dynamic>? params,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    return await (_dio.put(
      endUrl,
      data: data,
      queryParameters: params,
      cancelToken: cancelToken ?? _cancelToken,
      options: options,
    ));
  }

  Future<Response> post(
    BuildContext context,
    String endUrl, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? params,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    return await (_dio.post(
      endUrl,
      data: data,
      queryParameters: params,
      cancelToken: cancelToken ?? _cancelToken,
      options: options,
    ));
  }

  Future<Response> delete(
    BuildContext context,
    String endUrl, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? params,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    return await (_dio.delete(
      endUrl,
      data: data,
      queryParameters: params,
      cancelToken: cancelToken,
      options: options,
    ));
  }

  Future<Response> multipartPost(
    BuildContext context,
    String endUrl, {
    FormData? data,
    CancelToken? cancelToken,
    Options? options,
  }) async {
    return await (_dio.post(
      endUrl,
      data: data,
      cancelToken: cancelToken,
      options: options,
    ));
  }
}
