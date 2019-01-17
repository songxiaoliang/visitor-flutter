/**
 * 首页
 * Create by Songlcy 2018-12-25
 */
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import './tab_pages.dart';
import '../../constants/constant.dart';
import '../../models/state_model/tab_state_model.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin<HomePage>{
  
  static int lastExitTime = 0;
  TabBarStateModel tabBarStateModel;
  
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    tabBarStateModel = TabBarStateModel();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<TabBarStateModel>(
      model: tabBarStateModel,
      child:ScopedModelDescendant<TabBarStateModel>(
          builder: (context, child, model) {
            return Scaffold(
              body: _renderTabContent(model),
              bottomNavigationBar: _renderBottomNavigationBar(model),
            );
          },
        ),
    );
  }

  /**
   * 自定义返回键事件
   * 一定时间内点击两次退出，反之提示
   */
  Future<bool> _onBackPressed() async {
    int nowExitTime = DateTime.now().millisecondsSinceEpoch;
    if(nowExitTime - lastExitTime > 2000) {
      lastExitTime = nowExitTime;
      //  Toasty.info("再按一次退出程序");
      return await Future.value(false);
    }
    return await Future.value(true);
  }

  /**
   * Tab对应视图
   */
  _renderTabContent(TabBarStateModel model) {
    return IndexedStack(
      index: model.tabBarCurrentIndex,
      children: <Widget>[
        IndexPage(),
        PopularPage(),
        MoviePage(),
        MinePage()
      ],
    );
  }

  /**
   * TabBar
   */
  _renderBottomNavigationBar(TabBarStateModel model) {
    return BottomNavigationBar(
      items: _renderTabBarItem(model.tabBarCurrentIndex),
      onTap: (index) => model.changeTabBarCurrentIndex(index),
      currentIndex: model.tabBarCurrentIndex,
      type: BottomNavigationBarType.fixed, 
    );
  }

  /**
   * TabBarItem
   */
  List<BottomNavigationBarItem> _renderTabBarItem(int currentIndex) {
    return [
      BottomNavigationBarItem(icon: _getTabBarItemIcon(0, currentIndex),title: _getTabBarItemText(0, currentIndex)),
      BottomNavigationBarItem(icon: _getTabBarItemIcon(1, currentIndex),title: _getTabBarItemText(1, currentIndex)),
      BottomNavigationBarItem(icon: _getTabBarItemIcon(2, currentIndex),title: _getTabBarItemText(2, currentIndex)),
      BottomNavigationBarItem(icon: _getTabBarItemIcon(3, currentIndex),title: _getTabBarItemText(3, currentIndex)),
    ];
  }

  /**
   * TabBar图标
   */
  _getTabBarIcon(String path, Color color) {
    return Image.asset(path, width: 25.0, height: 25.0, color: color);
  }

  /**
   *  TabBar图标
   */
  Image _getTabBarItemIcon(index, currentIndex) {
    if(currentIndex == index) {
      return _getTabBarIcon(tabIcon[index][1], Theme.of(context).primaryColor);
    }
    return _getTabBarIcon(tabIcon[index][0], null);
  }

  /**
   * TabBar文字
   */
  Text _getTabBarItemText(index, currentIndex) {
    return Text(tabTitle[index], style: TextStyle(color: index == currentIndex ? Theme.of(context).primaryColor : Color.fromARGB(255,192, 193, 195)));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}


