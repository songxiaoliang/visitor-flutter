
/**
 * 首页数据状态Model
 * Create by Songlcy
 */
import 'package:scoped_model/scoped_model.dart';

import './base_state_model.dart';
import '../../common/api.dart';
import '../../utils/http_util.dart';
import '../../common/status.dart';
import '../pood/Index_tab_model.dart';
import '../pood/index_tab_page_model.dart';

class HomeStateModel extends BaseStateModel {

  Status _status = Status.READY;
  Status get status => _status;

  List<IndexTabModel> _tabList;
  List<IndexTabModel> get tabList => _tabList;

  IndexTabPageModel _indexTabPageModel;
  IndexTabPageModel get indexTabPageModel => _indexTabPageModel;

  Map<String, List<Hot>> hotMap = Map();

  /**
   * 加载首页Tab分类列表
   */
  fetchTabList() async {
    _status = Status.LOADING;
    await HttpUtil.get(INDEX_TAB_URL, null)
    .then((res) {
      _tabList = List();
      if(res.statusCode == Response.OK) {
        _status = Status.SUCCESS;
        var responseList = res.data;
        if(responseList != null) {
          if(responseList.length == 0) {
            _status = Status.NO_RESULT;
          } else {
            for(int i = 0; i < responseList.length; i++) {
              IndexTabModel indexTabModel = IndexTabModel.fromJson(responseList[i]);
              _tabList.add(indexTabModel);
            }
          }
        } else {
          _status = Status.NO_RESULT;
        }
        return _tabList;
      } else {
        _status = Status.NO_RESULT;
      }
    })
    .catchError((onError) {
      // _tabList = null
      print(onError.toString());
      _status = Status.ERROR;
    })
    .whenComplete(this.notifyListeners);
  }

  /**
   * 加载首页对应Tab分类
   */
  fetchIndexVideoList(String categoryId) {
    _status = Status.LOADING;
    Map<String, String> params = { "id": categoryId };
    HttpUtil.get(INDEX_VIDEO_LIST, params)
    .then((res) {
      if(res.statusCode == Response.OK) {
        _status = Status.SUCCESS;
        var responseData = res.data;
        if(responseData != null) {
          _indexTabPageModel = IndexTabPageModel.fromJson(responseData);
          hotMap.addAll({ categoryId: _indexTabPageModel.payload.hots });
        } else {
          _status = Status.NO_RESULT;
        }
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

  static HomeStateModel of(context) => 
    ScopedModel.of<HomeStateModel>(context, rebuildOnChange: true);
}