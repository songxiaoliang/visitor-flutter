/**
 * 主数据模型，需要全局使用的数据在这里添加模型
 * Create by Songlcy
 */
import 'package:scoped_model/scoped_model.dart';
import './theme_state_model.dart';

class MainStateModel extends Model with ThemeStateModel {
  
  static MainStateModel of(context) => ScopedModel.of<MainStateModel>(context, rebuildOnChange: true);

}

