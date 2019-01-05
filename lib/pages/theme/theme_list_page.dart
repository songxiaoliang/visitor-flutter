/**
 * 主题列表
 * Create by Songlcy
 */
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../constants/theme.dart';
import '../../components/empty_component.dart';
import '../../models/state_model/main_state_model.dart';

class ThemeListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ThemeListPageState();
}

class _ThemeListPageState extends State<ThemeListPage> {
  int themeIndex;
  _getDefaultTheme(BuildContext context) async {
    themeIndex = await ScopedModel.of<MainStateModel>(context).getTheme();
  }

  @override
  Widget build(BuildContext context) {
    _getDefaultTheme(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("更换主题"),
      ),
      body: _ThemeListBodyComponent(),
    );
  }
}

class _ThemeListBodyComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.countBuilder(
      crossAxisCount: 2,
      itemCount: themeList.length,
      itemBuilder: (BuildContext context, int index) => _renderThemeItem(index),
      staggeredTileBuilder: (int index) => new StaggeredTile.count(1, 0.5),
      mainAxisSpacing: 10.0,
      crossAxisSpacing: 10.0,
      padding: EdgeInsets.all(10.0),
      physics: BouncingScrollPhysics(),
    );
  }

  _renderThemeItem(int index) {
    return ScopedModelDescendant<MainStateModel>(
      builder: (context, child, model) {
        return MaterialButton(
          color: themeList[index],
          elevation: 0,
          onPressed: () => model.changeTheme(index),
          child: _renderButtonBody(model, index),
        );
    });
  }

  _renderButtonBody(MainStateModel model, index) {
    return model.themeIndex == index
    ? Center(
        child: Icon(Icons.check, color: Colors.white, size: 30.0),
      )
    : EmptyComponent();
  }
}
