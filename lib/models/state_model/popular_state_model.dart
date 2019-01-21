/**
 * 精选模块Model
 * Create by Songlcy
 */
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../pood/video_model.dart';
import './base_state_model.dart';
import '../../common/api.dart';
import '../../common/status.dart';
import '../../utils/http_util.dart';

class PopularStateModel extends BaseStateModel {

  List<VideoModel> _listData;
  Status status = Status.READY;
  Map<String, int> paging = { "page": 1, "per_page": 20 };

  List<VideoModel> get listData => _listData;

  Future<bool> fetchListData(String id) async {
    Map<String, dynamic> filterParams = { 
      "year": "2018",
      "area": "",
      "sort": "2",
      "query": "2",
      "source": "",
    };
    status = Status.LOADING;
    this.notifyListeners();
    await HttpUtil.get(VIDEO_LIST_URL + id, <String, dynamic>{}..addAll(filterParams)..addAll(paging))
    .then((res) {
      if(res.statusCode == Response.OK) {
        if(res.data["payload"]["result"].length == 0) {
          if(paging["page"] == 1) {
            status = Status.NO_RESULT;
            _listData = [];
          } else {
            status = Status.NO_MORE;
          }
        } else {
          // 有数据
          var responseList = res.data["payload"]["result"];
          if(paging["page"] == 1) {
            List<VideoModel> tempList = [];
            for(int i = 0; i < responseList.length; i++) {
              VideoModel videoModel = VideoModel.fromJson(responseList[i]);
              tempList.add(videoModel);
            }
            _listData = tempList;
          } else {
            for(int i = 0; i < responseList.length; i++) {
              VideoModel videoModel = VideoModel.fromJson(responseList[i]);
              _listData.add(videoModel);
            }
          }
          status = Status.SUCCESS;
        }
        return true;
      } else {
        _listData = [];
        return false;
      }
    })
    .catchError((onError){
      print(onError.toString());
      status = Status.ERROR;
      _listData = [];
      return false;
    })
    .whenComplete(this.notifyListeners);
    return true;
  }

  /**
   * 刷新
   */
  Future<Null> refreshListData(String id) async {
    if(status == Status.LOADING) {
      return null;
    }
    int oldPage = paging["page"];
    paging["page"] = 1;
    if(!await fetchListData(id)) {
      paging["page"] = oldPage;
    }
  }

  /**
   * 加载更多
   */
  Future<Null> loadMoreListData(String id) async {
    if(status == Status.LOADING) {
      return null;
    }
    paging["page"]++;
    if(!await fetchListData(id)) {
      paging["page"]--;
    }
  }

  static PopularStateModel of(BuildContext context) => ScopedModel.of<PopularStateModel>(context, rebuildOnChange: true);
}