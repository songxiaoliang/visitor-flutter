/**
 * 首页 Tab 界面
 * Create by Songlcy
 */
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';


import '../../route/routes.dart';
import '../../common/status.dart';
import '../../config/application.dart';
import '../../models/pood/video_model.dart';
import '../../components/empty_component.dart';
import '../../components/loading_component.dart';
import '../../components/data_empty_component.dart';
import '../../components/hero_image_component.dart';
import '../../models/pood/index_tab_page_model.dart';
import '../../models/state_model/home_state_model.dart';

class IndexTabPage extends StatefulWidget {

  final int index;
  final String name;
  final String categoryId;
  final HomeStateModel stateModel;

  const IndexTabPage({this.index, this.name, @required this.categoryId, @required this.stateModel});

  @override
  _IndexTabPageState createState() => _IndexTabPageState();
}

class _IndexTabPageState extends State<IndexTabPage> {
    // with AutomaticKeepAliveClientMixin<IndexTabPage> {
      
  @override
  void initState() {
    super.initState();
    widget.stateModel.fetchIndexVideoList(widget.categoryId);
  }

  // @override
  // bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<HomeStateModel>(
      builder: (context, child, model) {
        return _renderBody(model);
      },
    );
  }

  /**
   * 内容
   */
  _renderBody(HomeStateModel model) {
    return model.status == Status.LOADING
        ? LoadingComponent()
        : model.status == Status.SUCCESS
            ? _renderListView(model.hotMap[widget.categoryId])
            : DataEmptyComponent(status: model.status);
  }

  _renderListView(List<Hot> list) {
    if(list != null) {
      return StaggeredGridView.countBuilder(
        crossAxisCount: 4,
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) =>
            _ItemComponent(itemData: list[index]),
        staggeredTileBuilder: (int index) {
          return StaggeredTile.count(2, 2.6);
        }, // 列宽 和 高
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.only(
          top: 4.0,
          bottom: 4.0,
        ),
      );
    } 
    return EmptyComponent();
  }
}

class _ItemComponent extends StatelessWidget {

  final Hot itemData;
  const _ItemComponent({this.itemData});

  @override
  Widget build(BuildContext context) {
   
    return Stack(
      children: <Widget>[
        // fill 默认都为 0
        Positioned.fill(
          child: HeroImageComponent(imageItem:  VideoModel(
          id:itemData.id, 
          thumbnail: itemData.thumbnail, 
          generatedAt: itemData.generatedAt,
          latest: itemData.latest
        ))),
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
               itemData.latest,
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
                itemData.name,
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
              Hot video = itemData;
              Application.navigateTo(
                context: context, 
                route: "${Routes.videoDetail}?name=${Uri.encodeComponent(video.name)}&thumbnail=${Uri.encodeComponent(video.thumbnail)}&timestamp=${null}&id=${video.id}&latest=${Uri.encodeComponent(video.latest)}&generatedAt=${video.generatedAt}"
              );
            },  
          )
        )
      ],
    );
  }
}
