
import 'package:scoped_model/scoped_model.dart';
import './theme_model.dart';

class MainStateModel extends Model with ThemeStateModel {
  
  MainStateModel of(context) => ScopedModel.of<MainStateModel>(context, rebuildOnChange: true);
}

