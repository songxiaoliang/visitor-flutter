/**
 * 视频详情 Tab 页面
 * Create by Songlcy
 */
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../common/status.dart';
import '../../utils/time_util.dart';

import '../../models/pood/video_model.dart';
import '../../models/pood/video_detail_model.dart';
import '../../models/state_model/video_detail_state_model.dart';

import '../../components/tag_component.dart';
import '../../components/loading_component.dart';
import '../../components/data_empty_component.dart';
import '../../components//video_detail_item_component.dart';

class VideoDescTabPage extends StatelessWidget {

  final VideoModel videoModel;
  const VideoDescTabPage(this.videoModel);

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<VideoDetailStateModel>(
      builder: (context, child, model) {
        VideoDetailModel videoDetailModel = model.videoDetailModel;
        return model.status == Status.LOADING ?
        LoadingComponent()
        :
        model.status == Status.SUCCESS ?
        ListView(
          children: <Widget>[
            VideoDetailItemComponent(
              icon: "assets/images/icon_videodetail_name.png",
              content: "${videoModel.name}",
              child: TagComponent(
                title: model.videoDetailModel != null
                ? model.videoDetailModel.classify.name
                : ""
              ),
            ), 
            Container(
              margin: EdgeInsets.symmetric(vertical: 13.0),
              child: VideoDetailItemComponent(
                icon: "assets/images/icon_videodetail_director.png",
                content: "导演: ${model.videoDetailModel.director[0]}"
              )
            ), 
            VideoDetailItemComponent(
              icon: "assets/images/icon_videodetail_starring.png",
              content: "明星主演"
            ),
            Container(
              margin: EdgeInsets.fromLTRB(33.3, 8.0, 16.0, 0.0),
              child: Text("${videoDetailModel.starring.getRange(0, videoDetailModel.starring.length)}"),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 13.0),
                child: VideoDetailItemComponent(
                icon: "assets/images/icon_videodetail_num.png",
                content: "${videoModel.latest}"
              )
            ),
            VideoDetailItemComponent(
              icon: "assets/images/icon_videodetail_jishu.png",
              content: "[ 更新时间 ] ${TimeUtil.getTimeago(DateTime.parse(videoModel.generatedAt))}"
            ),
          ],
        )
        :
        DataEmptyComponent(status: model.status);
      },
    );
  }
}
