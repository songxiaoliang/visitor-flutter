/**
 * 网络请求结果枚举类
 * Create by Songlcy
 */
enum Status {
  READY, // 初始化
  LOADING, // 请求中
  SUCCESS, // 请求成功
  NO_RESULT, // 请求结果为空
  ERROR, // 请求失败
}

class Response {
  static int OK = 200;
}