/**
 * 我的界面 
 * Create by Songlcy
 */
import 'dart:core';
import 'package:flutter/material.dart';
import '../../config/application.dart';
import '../../route/routes.dart';
import '../../constants/api.dart';

class MinePage extends StatefulWidget {
  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: Text("Mine", style: TextStyle(fontFamily: "Lobster")),
      ),
      body: ListView(
        children: <Widget>[
          const _HeaderComponent(),
          const _OptionListItemComponent(),
          Container(
            margin: EdgeInsets.fromLTRB(10, 20, 10, 10),
            child: MaterialButton(
              height: 50.0,
              color: Theme.of(context).primaryColor,
              minWidth: MediaQuery.of(context).size.width - 20.0,
              child: Text("退出登录", style: TextStyle(color: Colors.white)),
              onPressed: (){

              },
            ),
          ),
        ],
      ),
    );
  }
}

class _HeaderComponent extends StatelessWidget {
  const _HeaderComponent();

  @override
  Widget build(BuildContext context) {
    return Container(
    height: 160.0,
    color: Theme.of(context).primaryColor,
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircleAvatar(
            radius: 40.0,
            child: Image.asset("assets/images/icon_default_avatar.png",
              width: 80.0, height: 80.0, fit: BoxFit.cover)),
          SizedBox(
            height: 10,
          ),
          InkWell(
            child: Text("请登录", style: TextStyle(color: Colors.white)),
          )
        ],
      ),
    ));
  }
}

class _OptionListItemComponent extends StatelessWidget {

  const _OptionListItemComponent();

  _navigate(BuildContext context, String route) {
    Application.navigateTo(context: context, route: route);
  }

  @override
  Widget build(BuildContext context) {
    Color themeColor = Theme.of(context).primaryColor;
    return Column(
      children: <Widget>[
        ListTile(
          title: Text("更换主题"),
          leading: Icon(Icons.sentiment_satisfied, color: themeColor),
          trailing: Icon(Icons.chevron_right, color: themeColor),
          onTap: () => _navigate(context, "${Routes.themeList}"),
        ),
        Divider(),
        ListTile(
          title: Text("我的博客"),
          leading: Icon(Icons.book, color: themeColor),
          trailing: Icon(Icons.chevron_right, color: themeColor),
          onTap: () => _navigate(context, "${Routes.webview}?title=${Uri.encodeComponent('我的博客')}&url=${Uri.encodeComponent(WEBSITE_URL)}"),
        ),
        Divider(),
        ListTile(
          title: Text("我的Github"),
          leading: Icon(Icons.web, color: themeColor),
          trailing: Icon(Icons.chevron_right, color: themeColor),
          onTap: () => _navigate(context, "${Routes.webview}?title=${Uri.encodeComponent('我的Github')}&url=${Uri.encodeComponent(GITHUB_URL)}"),
        ),
      ],
    );
  }
}
