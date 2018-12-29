/**
 * 首页Tab切换Model
 */

import './base_model.dart';

class TabBarChangeModel extends BaseStateModel {

  int _tabBarCurrentIndex = 0;

  get tabBarCurrentIndex => _tabBarCurrentIndex;

  void changeTabBarCurrentIndex(int currentIndex) {
    _tabBarCurrentIndex = currentIndex;
    notifyListeners();
  }
  
}