/**
 * 视频详情
 * Create by Songlcy
 */

class VideoDetailModel {
  // {
	// 	"classify": {
	// 		"_id": "5b1fdbee30025ae5371ac363",
	// 		"name": "动漫"
	// 	},
	// 	"director": ["濑藤健嗣"],
	// 	"favorited": false,
	// 	"favorited_count": 0,
	// 	"introduce": "本作是由东映动画、万代、小学馆共同发起的新企划，预定进行动画、漫画、玩具等多媒体展开。动画将于10月推出。",
	// 	"keyword": "爆钓BARHUNTER濑藤健嗣广桥凉内山夕实斋贺光希根本幸多baodiaoBARHUNTERlaitengjiansiguangqiaoliangneishanxishizhaiheguangxigenbenxingduobdBARHUNTERltjsgqlnsxszhgxgbxd",
	// 	"latest": "更新到16集",
	// 	"name": "爆钓BARHUNTER",
	// 	"number": 19,
	// 	"region": "日本",
	// 	"released_at": "2018",
	// 	"remote_url": [{
	// 		"tag": "第01集",
	// 		"url": "https://youku163.zuida-bofang.com/20181002/16132_d52aa48b/index.m3u8"
	// 	}],
	// 	"running_time": 0,
	// 	"source": "zuidazy",
	// 	"starring": ["广桥凉", "内山夕实", "斋贺光希", "根本幸多"],
	// 	"thumbnail": "https://tupian.tupianzy.com/pic/upload/vod/2018-10-02/201810021538485416.jpg"
	// }

  Classify classify;
  List<dynamic> director;
  bool favorited;
  int favoritedCount;
  String introduce;
  String keyword;
  String name;
  String region;
  List<RemoteUrl> remoteUrl;
  List<dynamic> starring;
  String releasedAt;
  String thumbnail;

  VideoDetailModel({
    this.classify,
    this.director,
    this.favorited,
    this.favoritedCount,
    this.introduce,
    this.keyword,
    this.name,
    this.region,
    this.remoteUrl,
    this.starring,
    this.releasedAt,
    this.thumbnail
  });

  factory VideoDetailModel.fromJson(Map<String, dynamic> jsonObj) {

    return VideoDetailModel(
      classify: Classify.fromJson(jsonObj["classify"]),
      director: jsonObj["director"],
      favorited: jsonObj["favorited"],
      favoritedCount: jsonObj["favoritedCount"],
      introduce: jsonObj["introduce"],
      keyword: jsonObj["keyword"],
      name: jsonObj["name"],
      region: jsonObj["region"],
      remoteUrl: (jsonObj["remote_url"] as List).map((item) => RemoteUrl.fromJson(item)).toList(),
      starring: jsonObj["starring"],
      releasedAt: jsonObj["released_at"],
      thumbnail: jsonObj["thumbnail"]
    );
  }
}
class Classify {

  String id;
  String name;

  Classify({ this.id, this.name });

  factory Classify.fromJson(Map<String, dynamic> jsonObj) {
    return Classify(id:jsonObj["_id"], name: jsonObj["name"]);
  }
}

class RemoteUrl {

  String tag;
  String url;

  RemoteUrl({ this.tag, this.url });

  factory RemoteUrl.fromJson(Map<String, dynamic> jsonObj) {
    return RemoteUrl(tag: jsonObj["tag"], url: jsonObj["url"]);
  }
}