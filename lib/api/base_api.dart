import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:tbs_app/config/constant.dart';
import 'package:dio/dio.dart';

class BaseApi {
  isWeb() {
    return kIsWeb;
  }

  buildUrl(path) {
    return kServerUrl + path;
  }

  getClient() {
    var options = BaseOptions(
      baseUrl: kServerUrl,
      connectTimeout: 5000,
      receiveTimeout: 3000,
    );
    var dio = Dio(options);
    dio.interceptors.add(
        LogInterceptor(request: true, responseBody: true, requestHeader: true));
    return dio;
  }
}
