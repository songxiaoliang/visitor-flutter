/**
 * 视频播放列表 Tab 页面
 * Create by Songlcy
 */
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:video_player/video_player.dart';

import '../../common/status.dart';
import '../../components/loading_component.dart';
import '../../components/data_empty_component.dart';
import '../../components/video_detail_item_component.dart';
import '../../models/pood/video_detail_model.dart';
import '../../models/state_model/video_detail_state_model.dart';

class VideoPlayTabPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<VideoDetailStateModel>(
      builder: (context, child, model) {
        return model.status == Status.LOADING
            ? LoadingComponent()
            : model.status == Status.SUCCESS
                ? 
                ListView.builder(
                  itemCount: model.videoDetailModel.remoteUrl.length,
                  itemBuilder: (BuildContext context, int index) =>
                      _ListItem(model.videoDetailModel, model.videoDetailModel.remoteUrl[index]),
                )
                : DataEmptyComponent(status: model.status);
      },
    );
  }
}

class _ListItem extends StatelessWidget {

  final RemoteUrl remoteUrl;
  final VideoDetailModel videoDetailModel;
  const _ListItem(this.videoDetailModel,this.remoteUrl);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      child: Center(
        child: MaterialButton(
            height: 30.0,
            child: Text(remoteUrl.tag, style: TextStyle(color: Colors.white)),
            color: Theme.of(context).primaryColor,
            onPressed: () => goToVideoPlayerPage(videoDetailModel, remoteUrl)
        )
      ),
    );
  }

  /**
   * 跳转视频播放界面
   */
  goToVideoPlayerPage(VideoDetailModel videoDetailModel, RemoteUrl remoteUrl) async {
    bool isHlS = remoteUrl.url.toLowerCase().endsWith(".m3u8");
    // 点播 hls需要exo2内核 并且硬件解码 mp4 需要ijk内核 软件解码
    await VideoPlayer.play(
      videoDetailModel.name,
      remoteUrl.url,
      videoDetailModel.thumbnail,
      id: videoDetailModel.classify.id,
      tag: remoteUrl.tag,
      seek: 0,
      append: "【Vistor】",
      kernel: isHlS ? 2 : 0,
    );
  }
}
