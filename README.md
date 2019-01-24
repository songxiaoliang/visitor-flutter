# Vistor-Flutter 视频类 App

## 博客链接：https://blog.csdn.net/u013718120/article/details/86621278

### 前言

##### 扫码安装Apk体验
<img src='https://www.pgyer.com/app/qrcode/poE0' />

##### 链接下载Apk安装
https://www.pgyer.com/poE0
 
### 模块
1.开发环境：
```xml
  Vs Code (1.30.2)
  Android Studio 3.+
```

2.开发框架 ( Flutter sdk: ">=2.0.0-dev.68.0 <3.0.0" )：
```xml
  状态管理：Scoped_model
  网络层：Dio
  导航库：Fluro
```

3.主模块分为首页、精选、电影、我的，以下是功能列表：
```xml
  使用 scoped_model 状态管理，实现state统一管理。
  使用 TabBar + TabBarView 实现单页面不同模块切换。
  使用 staggered_grid_view、ListView 组件展示图文列表。
  扩展列表组件，结合 NotificationManager 实现上拉加载更多数据，下拉刷新数据。
  精选内容，分类展示，使用SliverAppBar，增加交互动效，提高用户体验。
  自定义过滤菜单组件，结合 ScrollController 实现滑动交互效果。
  代码模块化  实现，组件封装实现代码复用。
```

### 功能设计
```xml
  1. 使用 Fluro 管理全局路由，可自由配置 Scene 的转场动画，处理Android端的后退键事件
  2. 使用 Flutter 基本语法进行布局，并封装了一系列通用的组件，比如 AnimationText、过滤菜单，加载状态组件，共享动画组件等，便于全局复用
  3. 数据层使用Dio实现 Http / Https 网络加载，可轻松实现 http header、链接超时等常用配置。
  4. 使用 CachedImage 组件，实现图片的加载缓存，优化渲染显示性能。
  5. 引入 scoped_model 状态管理，Scoped 结合 ScopedModelDescendant ，设定全局 state 结构，管理相关的组件状态。
  6. 使用 shared_preferences 实现小数据的本地化存储。
  7. 使用第三方字体库，实现 FontFamily 的定制显示。
  8. 设置 WillPopScope，实现首页点击返回键提示两次快按退出功能。
  ....
```

### 项目依赖库

部分图标采用了icons，查看具体的图标名称可到 ionics官方文档。依赖方式，cd 到项目根目录，执行：flutter get packages 
```xml
  dio: ^1.0.13
  fluro: ^1.4.0
  timeago: ^2.0.10
  scoped_model: ^1.0.1
  event_bus: ^1.0.1
  shimmer: ^0.0.6
  connectivity: ^0.3.2
  fluttertoast: ^2.2.7
  shared_preferences: ^0.4.3
  cached_network_image: ^0.5.1
  flutter_swiper: ^1.1.4
  flutter_spinkit: ^3.0.0
  flutter_staggered_grid_view: ^0.2.6
  flutter_webview_plugin: ^0.3.0+2
  video_player:
    git:
      url: https://github.com/songxiaoliang/flutter_video_player.git
```

### 待完善功能
```xml
 1. 登录
 2. 分享
 3. 支付
 4. 推送
 5. 局部窗口播放
```

### 效果图 （oneplus 5 Android 设备）

<img width="300" height="500" src='https://img-blog.csdnimg.cn/20190124101016565.jpg?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3UwMTM3MTgxMjA=,size_16,color_FFFFFF,t_70'/>
<img width="300" height="500" src='https://img-blog.csdnimg.cn/20190124101058299.jpg?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3UwMTM3MTgxMjA=,size_16,color_FFFFFF,t_70'/>
<img width="300" height="500" src='https://img-blog.csdnimg.cn/20190124101200245.jpg?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3UwMTM3MTgxMjA=,size_16,color_FFFFFF,t_70'/>
<img width="300" height="500" src='https://img-blog.csdnimg.cn/20190124101258765.jpg?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3UwMTM3MTgxMjA=,size_16,color_FFFFFF,t_70'/>
<img width="300" height="500" src='https://img-blog.csdnimg.cn/20190124101518712.jpg?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3UwMTM3MTgxMjA=,size_16,color_FFFFFF,t_70'/>
<img width="300" height="500" src='https://img-blog.csdnimg.cn/201901241014493.jpg?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3UwMTM3MTgxMjA=,size_16,color_FFFFFF,t_70'/><img width="500" height="300" src='https://img-blog.csdnimg.cn/20190124101345380.jpg?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3UwMTM3MTgxMjA=,size_16,color_FFFFFF,t_70'/>



