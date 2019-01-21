/**
 * 电影数据状态Model
 * Create by Songlcy
 */
import '../../common/api.dart';
import './base_state_model.dart';
import '../pood/video_model.dart';
import '../../common/status.dart';
import '../../utils/http_util.dart';

class MovieStateModel extends BaseStateModel{

  List<VideoModel> _movieList;
  Status status = Status.READY;
  Map<String, int> paging = { "page": 1, "per_page": 20 };

  List<VideoModel> get movieList => _movieList;

  Future<bool> fetchMovieList(String categoryId, Map<String, dynamic> filterParams) async {
    status = Status.LOADING;
    this.notifyListeners();
    await HttpUtil.get(VIDEO_LIST_URL + categoryId, <String, dynamic>{}..addAll(paging)..addAll(filterParams))
    .then((res) {
      if(res.statusCode == Response.OK) {
        if(res.data["payload"]["result"].length == 0) {
          if(paging["page"] == 1) {
            status = Status.NO_RESULT;
            _movieList = [];
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
            _movieList = tempList;
          } else {
            for(int i = 0; i < responseList.length; i++) {
              VideoModel videoModel = VideoModel.fromJson(responseList[i]);
              _movieList.add(videoModel);
            }
          }
          status = Status.SUCCESS;
        }
        return true;
      } else {
        _movieList = [];
        status = Status.NO_RESULT;
        return false;
      }
    })
    .catchError((onError){
      _movieList = [];
      status = Status.ERROR;
      print(onError.toString());
      return false;
    })
    .whenComplete(this.notifyListeners);
    return true;
  }

  /**
   * 刷新
   */
  Future<Null> refreshMovieList(String categoryId, Map<String, dynamic> filterParams) async {
    if(status == Status.LOADING) {
      return null;
    }
    int oldPage = paging["page"];
    paging["page"] = 1;
    if(!await fetchMovieList(categoryId, filterParams)) {
      paging["page"] = oldPage;
    }
  }

  /**
   * 加载更多
   */
  Future<Null> loadMoreMovieList(String categoryId, Map<String, dynamic> filterParams) async {
    if(status == Status.LOADING) {
      return null;
    }
    paging["page"]++;
    if(!await fetchMovieList(categoryId, filterParams)) {
      paging["page"]--;
    }
  }
}