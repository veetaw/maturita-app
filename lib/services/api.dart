import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/material.dart';

import 'package:dio/dio.dart';

import 'package:pizza/constants.dart';

class PizzaApi {
  static const String baseUrl = kApiBaseUrl;
  final Dio dio = Dio()
    ..interceptors.add(
      DioCacheManager(
        CacheConfig(baseUrl: baseUrl),
      ).interceptor,
    );

  Future<Response> get({
    @required String path,
    Map<String, dynamic> parameters,
    bool forceRefresh = false,
  }) async =>
      dio.get(
        baseUrl + path,
        queryParameters: parameters,
      );

  Future<Response> post({
    @required String path,
    Map<String, dynamic> parameters,
    Map<String, dynamic> body,
    bool forceRefresh = false,
  }) async =>
      dio.post(
        baseUrl + path,
        queryParameters: parameters,
        data: body,
      );

  Future<Response> patch({
    @required String path,
    Map<String, dynamic> parameters,
    Map<String, dynamic> body,
    bool forceRefresh = false,
  }) async =>
      dio.patch(
        baseUrl + path,
        queryParameters: parameters,
        data: body,
      );

  Future<Response> put({
    @required String path,
    Map<String, dynamic> parameters,
    Map<String, dynamic> body,
    bool forceRefresh = false,
  }) async =>
      dio.put(
        baseUrl + path,
        queryParameters: parameters,
        data: body,
      );

  Future<Response> delete({
    @required String path,
    Map<String, dynamic> parameters,
    Map<String, dynamic> body,
    bool forceRefresh = false,
  }) async =>
      dio.delete(
        baseUrl + path,
        queryParameters: parameters,
        data: body,
      );

  void addInterceptor(InterceptorsWrapper interceptor) {
    dio.interceptors.add(interceptor);
  }

  Interceptor getTokenInterceptor(String token) => InterceptorsWrapper(
        onRequest: (RequestOptions options) async {
          options.headers['authorization'] = 'bearer ' + token;
          return options;
        },
      );
}
