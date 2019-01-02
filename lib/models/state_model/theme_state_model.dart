
/**
 * 主题Model
 * Create by Songlcy
 */
import 'package:scoped_model/scoped_model.dart';
abstract class ThemeStateModel extends Model {

  int _themeIndex;

  get themeIndex => _themeIndex;

  void changeTheme(int themeIndex) {
    _themeIndex = themeIndex;
    notifyListeners();
  } 
}