/**
 * 视频详情
 * Create by Songlcy
 */
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:scoped_model/scoped_model.dart';

import './video_desc_tab_page.dart';
import './video_play_tab_page.dart';
import './video_plot_tab_page.dart';
import '../../utils/device_util.dart';
import '../../models/pood/video_model.dart';
import '../../constants/video_detail_tab.dart';
import '../../components/cached_image_component.dart';
import '../../components/hero_image_component.dart';
import '../../delegate/sliver_appbar_delegate.dart';
import '../../models/state_model/video_detail_state_model.dart';

class VideoDetailPage extends StatefulWidget {
  VideoModel videoItem;
  VideoDetailPage({@required this.videoItem});

  @override
  State<StatefulWidget> createState() => _VideoDetailPageState();
}

class _VideoDetailPageState extends State<VideoDetailPage> {
  VideoDetailStateModel videoDetailStateModel;

  @override
  void initState() {
    super.initState();
    videoDetailStateModel = new VideoDetailStateModel();
    videoDetailStateModel.fetchVideoDetail(widget.videoItem.id);
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: videoDetailStateModel,
      child: Scaffold(
        body: DefaultTabController(
          length: VIDEO_DETAIL_TAB.length,
          child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                // 标题
                SliverAppBar(
                  elevation: 0.0,
                  floating: false,
                  pinned: true,
                  expandedHeight:
                    DeviceUtil.getScreenSize(context).width * 1.05,
                  flexibleSpace: FlexibleSpaceBar(
                      title: Shimmer.fromColors(
                      baseColor: Colors.white,
                      highlightColor: Theme.of(context).primaryColor,
                      period: Duration(milliseconds: 6000),
                      child: Text(
                        "${widget.videoItem.name}",
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                    centerTitle: true,
                    background: HeaderBackGroundCover(widget.videoItem),
                  ),
                  actions: <Widget>[
                    // 收藏按钮
                  ],
                ),
                // Tab
                SliverPersistentHeader(
                  pinned: true,
                  delegate: SliverAppBarDelegate(TabBar(
                    labelColor: Theme.of(context).primaryColor,
                    labelStyle: TextStyle(fontSize: 16.5),
                    unselectedLabelColor: Color.fromARGB(255, 192, 193, 195),
                    indicatorColor: Theme.of(context).primaryColor,
                    indicatorWeight: 2.0,
                    tabs: VIDEO_DETAIL_TAB
                        .map<Tab>((item) => Tab(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  item["icon"],
                                  SizedBox(width: 3.0),
                                  Text(item["name"],
                                      style: TextStyle(fontSize: 15.0))
                                ],
                              ),
                            ))
                        .toList(),
                  )),
                )
              ];
            },
            body: VideoDetailContent(widget.videoItem),
          ),
        ),
      )
    );
  }
}

/**
 * 头部
 */
class HeaderBackGroundCover extends StatelessWidget {
  final VideoModel video;
  HeaderBackGroundCover(this.video);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          // 底图
          Positioned.fill(
            child: CachedImageComponent(
                imageUrl: video.thumbnail, boxFit: BoxFit.fill),
          ),
          // 毛玻璃
          Positioned(
              child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
              decoration: BoxDecoration(color: Colors.black.withAlpha(60)),
            ),
          )),
          // 内容
          Positioned(
              left: 0.0,
              top: 60.0,
              right: 0.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 200.0,
                    height: 290.0,
                    margin: EdgeInsets.only(left: 10.0),
                    child: HeroImageComponent(
                      imageItem: video,
                      imageWidth: 200.0,
                      imageHeight: 300.0,
                    ),
                    decoration: BoxDecoration(boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: Colors.black.withAlpha(50),
                          offset: Offset(0.0, 2.0),
                          blurRadius: 6.0),
                      BoxShadow(
                          color: Colors.black.withAlpha(20),
                          offset: Offset(0.0, 3.0),
                          blurRadius: 8.0)
                    ]),
                  )
                ],
              ))
        ],
      ),
    );
  }
}

class VideoDetailContent extends StatelessWidget {
  final VideoModel video;
  VideoDetailContent(this.video);

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: <Widget>[
        VideoDescTabPage(video),
        VideoPlayTabPage(),
        VideoPlotTabPage()
      ],
    );
  }
}
