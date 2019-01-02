/**
 * 网络请求
 * Create by Songlcy
 */
import 'package:dio/dio.dart';

Dio dio = Dio();

class HttpUtil {

  // get
  static Future get(String url, Map<String, dynamic> params) async {
    Response response = await dio.get(url, data: params);
    return response;
  }

  // post
  static Future post(String url, Map<String, dynamic> params) async {
    Response response = await dio.post(url, data: params);
    return response;
  }
}