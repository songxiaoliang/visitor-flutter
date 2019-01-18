/**
 * 路由配置
 * Create by Songlcy
 */
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import './route_handlers.dart';

class Routes {
  static String root = "/";
  static String webview = "/webview";
  static String themeList = "/themeList";
  static String videoDetail = "/videoDetail";

  static void configureRoutes(Router router) {
    
    router.define(themeList, handler: themeListRouteHandler);
    router.define(webview, handler: webviewRouteHandler);
    router.define(videoDetail, handler: videoDetailRouteHandler);

    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      print("ROUTE WAS NOT FOUND !!!");
    });
  }
}
