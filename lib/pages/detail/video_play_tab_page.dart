/**
 * 视频播放列表 Tab 页面
 * Create by Songlcy
 */
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../common/status.dart';
import '../../components/loading_component.dart';
import '../../components/data_empty_component.dart';

import '../../models/state_model/video_detail_state_model.dart';

class VideoPlayTabPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<VideoDetailStateModel>(
      builder: (context, child, model) {
        return model.status == Status.LOADING
            ? LoadingComponent()
            : model.status == Status.SUCCESS
                ? ListView.builder(
                    itemCount: model.videoDetailModel.remoteUrl.length,
                    itemBuilder: (BuildContext context, int index) =>
                        _ListItem(model.videoDetailModel.remoteUrl[index].tag),
                  )
                : DataEmptyComponent(status: model.status);
      },
    );
  }
}

class _ListItem extends StatelessWidget {
  final String content;
  const _ListItem(this.content);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      child: Center(
          child: MaterialButton(
              height: 30.0,
              child: Text(content, style: TextStyle(color: Colors.white)),
              color: Theme.of(context).primaryColor,
              onPressed: () {
                // 跳转播放界面
              })),
    );
  }
}
