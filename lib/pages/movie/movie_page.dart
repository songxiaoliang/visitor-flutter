/**
 * 电影
 * Create by Songlcy
 */
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../components/empty_component.dart';
import '../../components/hero_image_component.dart';
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
  
  Map<String, dynamic> _filterParams;
  ScrollController _scrollController;
  final String MOVIE_ID = "5b1362ab30763a214430d036";
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    initData();
    initListener();
    widget._filterBarStateModel.fetchMovieList(MOVIE_ID, _filterParams);
  }

  /**
   * 初始化数据
   */
  initData() {
     _filterParams = <String, dynamic>{
      "year": "",
      "area": "",
      "sort": "2",
      "query": "2",
      "source": "",
    };
  }

  /**
   * 设置事件监听
   */
  initListener() {
    _scrollController = ScrollController();
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
                return model.movieList != null ?
                StaggeredGridView.countBuilder(
                  shrinkWrap: true,
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
                ):
                EmptyComponent();
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
    return Stack(
      children: <Widget>[
        // fill 默认都为 0
        Positioned.fill(
          child: HeroImageComponent(imageItem: model.movieList[index])
        ),
        // 集数
        Positioned(
          top: 0.0,
          left: 0.0,
          child: Container(
            height: 20.0,
            padding: EdgeInsets.symmetric(horizontal: 5.0),
            color: Color.fromRGBO(0, 0, 0, 0.5),
            child: Center(
              child: Text(
                model.movieList[index]["latest"],
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10.0
                ),
              ),
            ),
          ),
        ),
        // 名称
        Positioned(
          left: 0.0,
          right: 0.0,
          bottom: 0.0,
          child: Container(
            height: 26.0,
            padding: EdgeInsets.symmetric(horizontal: 5.0),
            color: Color.fromRGBO(0, 0, 0, 0.5),
            child: Center(
              child: Text(
                model.movieList[index]["name"],
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13.0
                ),
              ),
            )
          ),
        ),
        Positioned.fill(
          child: MaterialButton(
            onPressed: () {
              //  跳转视频详情
            },  
          )
        )
      ],
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
