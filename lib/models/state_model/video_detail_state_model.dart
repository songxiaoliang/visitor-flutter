/**
 * 视频详情Model
 * Create by Songlcy
 */

import '../../common/api.dart';
import './base_state_model.dart';
import '../../common/status.dart';
import '../../utils/http_util.dart';
import '../pood/video_detail_model.dart';

class VideoDetailStateModel extends BaseStateModel {

  Status _status = Status.READY;
  VideoDetailModel _videoDetailModel;

  Status get status => _status;
  VideoDetailModel get videoDetailModel => _videoDetailModel;

  fetchVideoDetail(String videoId) {

    _status = Status.LOADING;
    HttpUtil.get(VIDEO_URL + videoId, null)
    .then((res) {
      if(res.statusCode == Response.OK) {
        _status = Status.SUCCESS;
        _videoDetailModel = VideoDetailModel.fromJson(res.data["payload"]);
      } else {
        _status = Status.NO_RESULT;
      }
    })
    .catchError((onError) {
      _status = Status.ERROR;
      print(onError.toString());
    })
    .whenComplete(this.notifyListeners);
  }

} 