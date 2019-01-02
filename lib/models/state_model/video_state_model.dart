/**
 * 视频数据状态Model
 * Create by Songlcy
 */
import 'dart:async';
import './base_state_model.dart';
import '../../constants/api.dart';
import '../../utils/http_util.dart';
import '../common/status_enum.dart';

class VideoStateModel extends BaseStateModel {

  List _videoList = [];
  Status status = Status.READY;

  get videoList => _videoList;

  fetchVideoListById(String categoryId) {
    Map paging = { "page": 1, "per_page": 20 };
    Map filterParams = {
      "year": "",
      "area": "",
      "sort": "2",
      "query": "2",
      "source": "",
      "classindex": "",
    };
    HttpUtil.get(VIDEO_LIST_URL + categoryId, {}..addAll(paging)..addAll(filterParams))
    .then((res){

    })
    .catchError((onError){

    })
    .whenComplete(this.notifyListeners);
  }



}