import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;
  static init() {
    dio = Dio(BaseOptions(
      baseUrl: 'https://student.valuxapps.com/api/',
      receiveDataWhenStatusError: true,
    ));
  }

  static Future<Response> getData({
    required String url,
    dynamic query,
    String lang = 'ar',
    String token = '',
  }) async {
    dio!.options.headers = {
      'language': lang,
      'Authorization': token,
      'Content-Type': 'application/json',
    };
    return await dio!.get(
      url,
      queryParameters: query,
    );
  }

  static Future<Response> postData({
    required String url,
    dynamic query,
    required dynamic data,
    String lang = 'ar',
    String token = '',
  }) async {
    dio!.options.headers = {
      'language': lang,
      'Authorization': token,
      'Content-Type': 'application/json',
    };
    return await dio!.post(
      url,
      queryParameters: query,
      data: data,
    );
  }

  static Future<Response> putData({
    required String url,
    dynamic query,
    required dynamic data,
    String lang = 'ar',
    String token = '',
  }) async {
    dio!.options.headers = {
      'language': lang,
      'Authorization': token,
      'Content-Type': 'application/json',
    };
    return await dio!.put(
      url,
      queryParameters: query,
      data: data,
    );
  }
}