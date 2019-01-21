/**
 * 视频实体类
 * Create by Songlcy
 */
class VideoModel {
  // {
	// 		"_id": "5b6ac0c36384664afd73c1d0",
	// 		"generated_at": "2019-01-20T11:38:54Z",
	// 		"latest": "第40集",
	// 		"name": "咯咯咯鬼太郎6",
	// 		"source": "kuyunzy",
	// 		"thumbnail": "https://img.kuyun88.com/pic/uploadimg/2018-5/2018562284825623.jpg"
  // }
  String id;
  String generatedAt;
  String latest;
  String name;
  String source;
  String thumbnail;
  String timestamp;

  VideoModel({ this.id, this.generatedAt, this.latest, this.name, this.source, this.thumbnail, this.timestamp });

  factory VideoModel.fromJson(Map<String, dynamic> jsonObj) {
    return VideoModel(
      id: jsonObj["_id"],
      generatedAt: jsonObj["generated_at"],
      latest: jsonObj["latest"],
      name: jsonObj["name"],
      source: jsonObj["source"],
      thumbnail: jsonObj["thumbnail"],
      timestamp: jsonObj["timestamp"]
    );
  }
}