/**
 * 首页
 * Create by Songlcy 2018-12-25
 */
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../models/state_model/main_model.dart';
import './tab_pages.dart';
import '../../constants/constant.dart';

class HomePage extends StatefulWidget {

  @override
  _HomeSceneState createState() => _HomeSceneState();
}

class _HomeSceneState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainStateModel>(
      builder: (context, child, model) {
        return Scaffold(
          body: _renderTabContent(model),
          bottomNavigationBar: _renderBottomNavigationBar(model),
        );
      },
    );
  }

  /**
   * Tab 内容
   */
  _renderTabContent(MainStateModel model) {
    return IndexedStack(
      index: model.tabBarCurrentIndex,
      children: <Widget>[
        IndexPage(),
        FeaturePage(),
        PopularPage(),
        MoviePage(),
        MinePage()
      ],
    );
  }

  /**
   * TabBar
   */
  _renderBottomNavigationBar(MainStateModel model) {
    return BottomNavigationBar(
      items: _renderTabBarItem(model.tabBarCurrentIndex),
      onTap: (index) => model.changeTabBarCurrentIndex(index),
      currentIndex: model.tabBarCurrentIndex,
      type: BottomNavigationBarType.fixed, 
      fixedColor: Colors.white,
    );
  }

  List<BottomNavigationBarItem> _renderTabBarItem(int currentIndex) {
    return [
      BottomNavigationBarItem(icon: _getTabBarItemIcon(0, currentIndex),title: _getTabBarItemText(0, currentIndex)),
      BottomNavigationBarItem(icon: _getTabBarItemIcon(1, currentIndex),title: _getTabBarItemText(1, currentIndex)),
      BottomNavigationBarItem(icon: _getTabBarItemIcon(2, currentIndex),title: _getTabBarItemText(2, currentIndex)),
      BottomNavigationBarItem(icon: _getTabBarItemIcon(3, currentIndex),title: _getTabBarItemText(3, currentIndex)),
      BottomNavigationBarItem(icon: _getTabBarItemIcon(4, currentIndex),title: _getTabBarItemText(4, currentIndex)),
    ];
  }

  _getTabBarIcon(String path) {
    return Image.asset(path, width: 25.0, height: 25.0);
  }

  /**
   *  TabBar图标
   */
  Image _getTabBarItemIcon(index, currentIndex) {
    if(currentIndex == index) {
      return _getTabBarIcon(tabIcon[index][1]);
    }
    return _getTabBarIcon(tabIcon[index][0]);
  }

  /**
   * TabBar文字
   */
  Text _getTabBarItemText(index, currentIndex) {
    return Text(tabTitle[index], style: TextStyle(color: index == currentIndex ? Color.fromARGB(255, 51, 51, 51) : Color.fromARGB(255,192, 193, 195)));
  }
}


