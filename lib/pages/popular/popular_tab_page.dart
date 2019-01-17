/**
 * 精选 Tab 详情页
 * Create by Songlcy
 */
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../components/list_bottom_indicator.dart';
import '../../models/state_model/popular_state_model.dart';

class PopularTabPage extends StatefulWidget {

  String id;
  PopularTabPage({@required this.id});

  @override
  State<StatefulWidget> createState() => _PopularTabPageState();
}

class _PopularTabPageState extends State<PopularTabPage> {

  ScrollController _scrollController = ScrollController();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
    GlobalKey<RefreshIndicatorState>();
  PopularStateModel _popularStateModel = PopularStateModel();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener((){
      if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        _onListLoadMore();
      }
    });
    _popularStateModel.fetchListData(widget.id);
  }

  /**
   * 刷新
   */
  Future<Null> _onListRefresh() async {
    await PopularStateModel.of(context).fetchListData(widget.id);
  }

  /**
   * 加载更多
   */
  Future<Null> _onListLoadMore() async {
    await PopularStateModel.of(context).loadMoreListData(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<PopularStateModel>(
      model: _popularStateModel,
      child: RefreshIndicator(
        key: _refreshIndicatorKey,
        color: Theme.of(context).primaryColor,
        onRefresh: () => _onListRefresh(),
        child: ScopedModelDescendant<PopularStateModel>(
        builder: (context, child, model) {
          return StaggeredGridView.countBuilder(
            controller: _scrollController,
            crossAxisCount: 4,
            itemCount: model.listData.length + 1,
            itemBuilder: (BuildContext context, int index) =>
              _buildListItem(context, model, index),
            staggeredTileBuilder: (int index) {
              if (index == model.listData.length) {
                return StaggeredTile.count(4, 0.7);
              }
              return StaggeredTile.count(2, 2.6);
            },
            mainAxisSpacing: 4.0,
            crossAxisSpacing: 4.0,
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.only(
              top: 4.0,
              bottom: 4.0,
            ),
          );
        },
      ),
      ) 
    );
  }

    /**
   * 列表项
   */
  _buildListItem(BuildContext context, PopularStateModel model, int index) {
    if (model.listData != null && index == model.listData.length) {
      // 最后一项
      return ListBottomIndicator(
        status: model.status,
        onPressCallback: ()=> this.onPressCallback(model)
      );
    }
    return Container(
      width: 200,
      height: 400,
      child: Image.network(model.listData[index]["thumbnail"],
          width: 200.0, height: 400.0, fit: BoxFit.cover),
    );
  }

  /**
   * 列表底部回调
   */
  onPressCallback(PopularStateModel model) {
    if (model.listData.length == 0) {
      // 刷新
      _onListRefresh();
    } else {
      // 继续加载下一页
      _onListLoadMore();
    }
  }
}
