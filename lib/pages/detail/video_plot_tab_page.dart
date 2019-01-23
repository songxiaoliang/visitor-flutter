/**
 * 视频剧情 Tab 页面
 * Create by Songlcy
 */
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../common/status.dart';
import '../../components/loading_component.dart';
import '../../components/data_empty_component.dart';
import '../../components/video_detail_item_component.dart';
import '../../models/pood/video_detail_model.dart';
import '../../models/state_model/video_detail_state_model.dart';

class VideoPlotTabPage extends StatelessWidget {

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
              icon: "assets/images/icon_videodetail_desc.png",
              content: "剧情"
            ),
            Container(
              margin: EdgeInsets.all(13.0),
              child: Text(
                "${videoDetailModel.introduce}", 
                textAlign: TextAlign.left,
                style: TextStyle(
                  letterSpacing: 1.0
                ),
              )
            )
          ],
        )
        :
        DataEmptyComponent(status: model.status);
      },
    );
  }
}
