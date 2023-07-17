import 'package:dio/dio.dart';

import 'endpoints.dart';

class DioHelper {
  static Dio? dio;
  static String baseUrl = 'https://3e97-105-37-106-140.ngrok-free.app/monkey%20pox%20detection/backEnd/public/api/auth/';

  static void init() {
    dio = Dio(
      BaseOptions(
          baseUrl: baseUrl,
          receiveDataWhenStatusError: true,
          followRedirects: false,
          validateStatus: (status) => true,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
          connectTimeout: 30000,
          sendTimeout: 10000,
          receiveTimeout: 30000),
    );
  }

  static Future<Response> postData(
      {required String endPoint,
        Map<String, dynamic>? data,
        String? token}) async {
    // dio!.options.headers = {
    //   'Content-Type': "application/json",
    //   'Authorization': "Bearer ${EndPoint.userToken}"
    // };
    return await dio!.post(endPoint, data: data);
  }

  static Future<Response> postImage(
      {required String endPoint,
        var data,
        String? token}) async {
    // dio!.options.headers = {
    //   'Content-Type': "application/json",
    //   'Authorization': "Bearer ${EndPoint.userToken}"
    // };
   // 5 seconds
    return await dio!.post(endPoint, data: data);
  }

  static Future<Response> getData(
      {required String endPoint,
        String? token,
        Map<String, dynamic>? header}) async {
    dio!.options.headers = header ??
        {
          'Content-Type': 'application/json',
          'Authorization': "Bearer ${EndPoint.userToken}",
        };
    return await dio!.get(endPoint);
  }

  static Future<Response> putData(
      {required String endPoint,
        Map<String, dynamic>? data,
        String? token}) async {
    dio!.options.headers = {
      'Content-Type': "application/json",
      'Authorization': "Bearer ${EndPoint.userToken}"
    };
    return await dio!.put(endPoint, data: data);
  }
}