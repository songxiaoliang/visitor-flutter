/**
 * 网络请求
 * Create by Songlcy
 */
import 'package:dio/dio.dart';

Options options = Options(
  // 连接服务器超时时间(毫秒)
  // connectTimeout: 10000,
  // receiveTimeout: 30000,
  headers: {
    "Content-Type": "application/json",
    "Accept": "application/json",
    // "Authorization": "Bearer " + access_token
  }
);

class HttpUtil {

  // get
  static Future get(String url, Map<String, dynamic> params) async {
    Response response = await Dio(options).get(url, data: params);
    return response;
  }

  // post
  static Future post(String url, Map<String, dynamic> params) async {
    Response response = await Dio(options).post(url, data: params);
    return response;
  }
}