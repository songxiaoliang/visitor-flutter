/**
 * 路由定义
 * Create by Songlcy
 */
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

import '../pages/theme/theme_list_page.dart';
import '../pages/detail/video_detail_page.dart';
import '../models/pood/video_model.dart';

var themeListRouteHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return ThemeListPage();
  }
);

var videoDetailRouteHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    String id = params["id"]?.first;
    String timestamp = params["timestamp"]?.first;
    String thumbnail = params["thumbnail"]?.first;
    String name = params["name"]?.first;
    return VideoDetailPage(
      videoItem: VideoModel(
        id: id,
        name: name,
        thumbnail: thumbnail,
        timestamp: timestamp,
      )
    );
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