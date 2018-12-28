/**
 * 首页
 * Create by Songlcy 2018-12-25
 */
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../models/state_model/main_model.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainStateModel>(
      builder: (context, child, model) {
        return  Scaffold(
          body: _renderTabContent(),
          bottomNavigationBar: _renderBottomNavigationBar(),
        );
      },
    );
  }

  /**
   * Tab 内容
   */
  _renderTabContent() {
    return IndexedStack(
      index: _currentIndex,
      children: <Widget>[
        
      ],
    )
  }

  /**
   * TabBar
   */
  _renderBottomNavigationBar() {

  }

  }


