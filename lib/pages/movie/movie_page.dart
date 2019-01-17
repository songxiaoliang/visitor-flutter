/**
 * 电影
 * Create by Songlcy
 */
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../common/status.dart';
import '../../components/filter_bar_component.dart';
import '../../components/list_bottom_indicator.dart';
import '../../models/state_model/filter_state_model.dart';


class MoviePage extends StatefulWidget {
  @override
  _MoviePageState createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  FilterStateModel _filterBarStateModel;

  @override
  void initState() {
    super.initState();
    FilterBarIndexState _filterBarIndexState = FilterBarIndexState();
    _filterBarStateModel = FilterStateModel(_filterBarIndexState);
    _filterBarStateModel.init();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<FilterStateModel>(
        model: _filterBarStateModel,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text("Movie", style: TextStyle(fontFamily: 'Lobster')),
            actions: <Widget>[
              IconButton(
                tooltip: "过滤",
                icon: Icon(Icons.sort),
                onPressed: () {
                  // 打开排序列表
                  _filterBarStateModel.toggleOpenStatus();
                },
              )
            ],
          ),
          body: _MovieListComponent(_filterBarStateModel),
        ));
  }
}

class _MovieListComponent extends StatefulWidget {
  FilterStateModel _filterBarStateModel;
  _MovieListComponent(this._filterBarStateModel);

  @override
  State<StatefulWidget> createState() => _MovieListComponentState();
}

class _MovieListComponentState extends State<_MovieListComponent> {
  final String MOVIE_ID = "5b1362ab30763a214430d036";

  ScrollController _scrollController = ScrollController();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  Map<String, dynamic> _filterParams = <String, dynamic>{
    "year": "",
    "area": "",
    "sort": "2",
    "query": "2",
    "source": "",
  };

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (widget._filterBarStateModel.isOpen) {
        // 滑动状态中，关闭过滤菜单
        widget._filterBarStateModel.toggleOpenStatus();
      }
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        // 列表滑到最底部，加载更多
        _onListLoadMore();
      }
    });
    widget._filterBarStateModel.fetchMovieList(MOVIE_ID, _filterParams);
  }

  /**
   * 过滤选择回调
   */
  _onItemSelectCallback(params) {
    _filterParams[params["key"]] = params["value"];
    _refreshIndicatorKey.currentState.show();
    _scrollController.jumpTo(0.0);
  }

  /**
   * 刷新
   */
  Future<Null> _onListRefresh() async {
    await FilterStateModel.of(context).refreshMovieList(MOVIE_ID, _filterParams);
  }

  /**
   * 加载更多
   */
  _onListLoadMore() {
    FilterStateModel.of(context).loadMoreMovieList(MOVIE_ID, _filterParams);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      key: _refreshIndicatorKey,
      color: Theme.of(context).primaryColor,
      onRefresh: () => _onListRefresh(),
      child: Column(
        children: <Widget>[
          FilterBarComponent(
            itemNums: FilterStateModel.of(context).itemList.length,
            onItemSelectCallback: (params) =>
                _onItemSelectCallback(params)),
          Expanded(
            child: ScopedModelDescendant<FilterStateModel>(
              builder: (context, child, model) {
                return StaggeredGridView.countBuilder(
                  controller: _scrollController,
                  crossAxisCount: 4,
                  itemCount: model.movieList.length + 1,
                  itemBuilder: (BuildContext context, int index) =>
                      _buildMovieListItem(model, index),
                  staggeredTileBuilder: (int index) {
                    if (index == model.movieList.length) {
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
              }
            )
          )
        ],
      ));
  }

  /**
   * 列表项
   */
  _buildMovieListItem(FilterStateModel model, int index) {
    if (model.movieList != null && index == model.movieList.length) {
      // 最后一项
      return ListBottomIndicator(
        status: model.status,
        onPressCallback: ()=> this.onPressCallback(model),
      );
    }
    return Container(
      width: 200,
      height: 400,
      child: Image.network(model.movieList[index]["thumbnail"],
          width: 200.0, height: 400.0, fit: BoxFit.cover),
    );
  }

  /**
   * 列表最后一项显示
   */
  onPressCallback(FilterStateModel model) {
    if (model.movieList.length == 0) {
      // 刷新
      _onListRefresh();
    } else {
      // 继续加载下一页
      _onListLoadMore();
    }
  }
}
