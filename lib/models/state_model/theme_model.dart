
/**
 * 主题Model
 * Create by Songlcy
 */
import './base_model.dart';

abstract class ThemeStateModel extends BaseStateModel {

  int _themeIndex;

  get themeIndex => _themeIndex;

  void changeTheme(int themeIndex) {
    _themeIndex = themeIndex;
    notifyListeners();
  } 
}