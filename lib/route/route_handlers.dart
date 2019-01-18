/**
 * 路由定义
 * Create by Songlcy
 */
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

import '../pages/theme/theme_list_page.dart';
import '../pages/detail/video_detail_page.dart';

var themeListRouteHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return ThemeListPage();
  }
);

var videoDetailRouteHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return VideoDetailPage();
  }
);


var webviewRouteHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    String title = params["title"]?.first;
    String url = params["url"]?.first;
    return WebviewScaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(title),
      ),
      url: url,
    );
  }
);