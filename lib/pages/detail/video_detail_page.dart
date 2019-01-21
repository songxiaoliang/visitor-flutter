/**
 * 视频详情
 * Create by Songlcy
 */
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../utils/device_util.dart';
import '../../models/pood/video_model.dart';
import '../../constants/video_detail_tab.dart';
import '../../components/cached_image_component.dart';
import '../../components/hero_image_component.dart';
import '../../delegate/sliver_appbar_delegate.dart';

class VideoDetailPage extends StatefulWidget {

  VideoModel videoItem;
  VideoDetailPage({ @required this.videoItem });

  @override
  State<StatefulWidget> createState() => _VideoDetailPageState();
}

class _VideoDetailPageState extends State<VideoDetailPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: VIDEO_DETAIL_TAB.length,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              // 标题
              SliverAppBar(
                elevation: 0.0,
                floating: true,
                pinned: true,
                expandedHeight: DeviceUtil.getScreenSize(context).width * 1.05,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text("${widget.videoItem.name}"),
                  centerTitle: true,
                  background: HeaderBackGroundCover(widget.videoItem),
                ),
                actions: <Widget>[
                  // 收藏按钮
                ],
              ),
              // Tab
              SliverPersistentHeader(
                delegate: SliverAppBarDelegate(
                  TabBar(
                    labelColor: Theme.of(context).primaryColor,
                    labelStyle: TextStyle(fontSize: 16.5),
                    unselectedLabelColor: Color.fromARGB(255,192, 193, 195),
                    indicatorColor: Theme.of(context).primaryColor,
                    indicatorWeight: 2.0,
                    tabs: VIDEO_DETAIL_TAB.map<Tab>((item) => Tab(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          item["icon"],
                          SizedBox(width: 3.0),
                          Text(
                            item["name"], 
                            style: TextStyle(fontSize: 15.0)
                          )
                        ],
                      ),
                    )).toList(),
                  )
                ),
              )
            ];
          },
          body: const VideoDetailContent(),
        ),
      ),
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
            child: CachedImageComponent(imageUrl: video.thumbnail, boxFit: BoxFit.fill),
          ),
          // 毛玻璃
          Positioned(child: BackdropFilter(
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
                  height: 300.0,
                  margin: EdgeInsets.only(left: 10.0),
                  child: HeroImageComponent(imageItem: video,imageWidth: 200.0,imageHeight: 300.0,),
                  decoration: BoxDecoration(
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.black.withAlpha(50),
                        offset: Offset(0.0, 2.0),
                        blurRadius: 6.0
                      ),
                      BoxShadow(
                        color: Colors.black.withAlpha(20),
                        offset: Offset(0.0, 3.0),
                        blurRadius: 8.0
                      )
                    ]
                  ),
                )
              ],
            )
          )
        ],
      ),
    );
  }
}

class VideoDetailContent extends StatelessWidget {

  const VideoDetailContent();

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: <Widget>[
        ListView(
          children: <Widget>[Text("123")],
        ),
        ListView(
          children: <Widget>[Text("456")],
        )
      ],
    );
  }
}