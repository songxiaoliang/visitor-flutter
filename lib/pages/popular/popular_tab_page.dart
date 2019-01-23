/**
 * 精选 Tab 详情页
 * Create by Songlcy
 */
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../route/routes.dart';
import '../../config/application.dart';
import '../../models/pood/video_model.dart';
import '../../components/empty_component.dart';
import '../../components/hero_image_component.dart';
import '../../components/list_bottom_indicator.dart';
import '../../models/state_model/popular_state_model.dart';

class PopularTabPage extends StatefulWidget {

  String id;
  PopularTabPage({@required this.id});

  @override
  State<StatefulWidget> createState() => _PopularTabPageState();
}

class _PopularTabPageState extends State<PopularTabPage> with AutomaticKeepAliveClientMixin{
  
  PopularStateModel _popularStateModel; 
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
    GlobalKey<RefreshIndicatorState>();
  
  // final NotificationListenerCallback<ScrollNotification> onScrollNotification;
  
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    initData();
    _popularStateModel.fetchListData(widget.id);
  }

  initData() {
    _popularStateModel = PopularStateModel();
  }

  /**
   * 刷新
   */
  Future<Null> _onListRefresh(BuildContext context) async {
    await _popularStateModel.fetchListData(widget.id);
  }

  /**
   * 加载更多
   */
  Future<Null> _onListLoadMore() async {
    await _popularStateModel.loadMoreListData(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<PopularStateModel>(
      model: _popularStateModel,
      child: RefreshIndicator(
        key: _refreshIndicatorKey,
        color: Theme.of(context).primaryColor,
        onRefresh: () => _onListRefresh(context),
        child: ScopedModelDescendant<PopularStateModel>(
        builder: (context, child, model) {
          return model.listData != null ?
          NotificationListener(
            onNotification: _handleScrollNotification,
            child: CustomScrollView(
              shrinkWrap: true,
              // controller: _scrollController,
              physics: BouncingScrollPhysics(),
              slivers: <Widget>[
                SliverStaggeredGrid.countBuilder(
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
                )
              ],
            ),
          )
          :
          EmptyComponent();
        },
      ),
      ) 
    );
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    // if (onScrollNotification != null) onScrollNotification(notification);

    if (notification.depth != 0) return false;

    // reach the pixels to loading more
    if (notification.metrics.axisDirection == AxisDirection.down &&
        notification.metrics.pixels == notification.metrics.maxScrollExtent) {
        _onListLoadMore();
    }
    return false;
  }

  /**
   * 列表项
   */
  _buildListItem(BuildContext context, PopularStateModel model, int index) {
    if (model.listData != null && index == model.listData.length) {
      return ListBottomIndicator(
        status: model.status,
        onPressCallback: ()=> this.onPressCallback(model)
      );
    }
    return Stack(
      children: <Widget>[
        // fill 默认都为 0
        Positioned.fill(
          child: HeroImageComponent(imageItem: model.listData[index])
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
                model.listData[index].latest,
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
                model.listData[index].name,
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
              VideoModel video = model.listData[index];
              Application.navigateTo(
                context: context, 
                route: "${Routes.videoDetail}?name=${Uri.encodeComponent(video.name)}&thumbnail=${Uri.encodeComponent(video.thumbnail)}&timestamp=${video.timestamp}&id=${video.id}&latest=${Uri.encodeComponent(video.latest)}&generatedAt=${video.generatedAt}"
              );
            },  
          )
        )
      ],
    );
  }

  /**
   * 列表底部回调
   */
  onPressCallback(PopularStateModel model) {
    if (model.listData.length == 0) {
      // 刷新
      _onListRefresh(context);
    } else {
      // 继续加载下一页
      _onListLoadMore();
    }
  }
}
