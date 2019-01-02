/**
 * 首页 Tab 界面
 * Create by Songlcy
 */
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../models/state_model/home_state_model.dart';
import '../../components/empty_component.dart';

class IndexTabPage extends StatefulWidget {
  
  String categoryId;
  HomeStateModel stateModel;

  IndexTabPage({
    Key key,
    @required this.categoryId, 
    @required this.stateModel 
  }):super(key: key);

  @override
  _IndexTabPageState createState() => _IndexTabPageState();
}

class _IndexTabPageState extends State<IndexTabPage> with AutomaticKeepAliveClientMixin<IndexTabPage> {
  
  @override
  void initState() {
    super.initState();
    widget.stateModel.fetchIndexVideoList(widget.categoryId);
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<HomeStateModel>(
      builder: (context, child, model) {
        if(model.indexTabPageModel != null) {
          return StaggeredGridView.countBuilder(
            crossAxisCount: 4,
            itemCount: 8,
            itemBuilder: (BuildContext context, int index) => new Container(
                color: Colors.green,
                child: Image.network(model.indexTabPageModel.payload.hots[index].thumbnail,width: 200, height: 200,)
            ),
            staggeredTileBuilder: (int index) =>
                new StaggeredTile.count(2, index.isEven ? 2 : 1),
            mainAxisSpacing: 4.0,
            crossAxisSpacing: 4.0,
          );
        } else {
          return EmptyComponent();
        }
      },
    );
  }
}
