/**
 * 首页Tab列表实体类
 * 对于嵌套结构，首先创建类和构造函数，然后从底层添加工厂方法。
 * Create by Songlcy
 */
class IndexTabPageModel {
  
  String message;
  String success;
  PayLoad payload;

  IndexTabPageModel({ this.message, this.success, this.payload });

  factory IndexTabPageModel.fromJson(Map<String, dynamic> jsonObj) {
    return new IndexTabPageModel(
      message: jsonObj["_id"], 
      success: jsonObj["name"],
      payload: PayLoad.fromJson(jsonObj["payload"])
    );
  }
}

class PayLoad {
  List<Ads> ads;
  List<Banner> banner;
  List<Hot> hots;
  List<Latest> latests;

  PayLoad({ this.ads, this.banner, this.hots, this.latests });

  factory PayLoad.fromJson(Map<String, dynamic> jsonObj) {
    return PayLoad(
      ads: (jsonObj["ads"] as List).map((item) => Ads.fromJson(item)).toList(),
      banner: (jsonObj["banner"] as List).map((item) => Banner.fromJson(item)).toList(),
      hots: (jsonObj["hots"] as List).map((item) => Hot.fromJson(item)).toList(),
      latests: (jsonObj["latests"] as List).map((item) => Latest.fromJson(item)).toList(),
    );
  }
}

class Action {
  /**
   * "data": "https://www.shuidichou.com/cf/contribute/caff17ed-905e-460b-a65a-8f0e943d47ae?channel=wx_charity_hy",
	 * "type": "browser"
   */
  String data;
  String type;

  Action({ this.data, this.type });

  factory Action.fromJson(Map<String, dynamic> jsonObj) {
    return Action(
      data: jsonObj["data"],
      type: jsonObj["type"]
    );
  }
}

class Ads {
  /**
   * 	"action": {
        "data": "Nl7FJ976sg",
        "type": "alipay_readpack"
      },
   *  "image": "https://dd.shmy.tech/static/ads/alipay/alipay_redpack.png",
   *  "height": 0.6
   */
  Action action;
  double height;
  String image;
  
  Ads({ this.action, this.height, this.image });

  factory Ads.fromJson(Map<String, dynamic> jsonObj) {
    return Ads(
      action: Action.fromJson(jsonObj["action"]),
      height: jsonObj["height"],
      image: jsonObj["image"],
    );
  }
}

class Banner {
  /**
   * 	"action": {
        "data": "Nl7FJ976sg",
        "type": "alipay_readpack"
      },
   *  "image": "https://dd.shmy.tech/static/ads/alipay/alipay_redpack.png",
   *  "name": "你好，Flutter"
   */
  Action action;
  String name;
  String image;

  Banner({ this.action, this.name, this.image });

  factory Banner.fromJson(Map<String, dynamic> jsonObj) {
    return Banner(
      action: Action.fromJson(jsonObj["action"]),
      name: jsonObj['name'],
      image: jsonObj['image'],
    );
  }

}

class Hot {
  /**
   * {
				"_id": "5bc93aad6e225858e54835c1",
				"generated_at": "2018-12-18T01:25:14Z",
				"latest": "更新到08集",
				"name": "十全八美第一季",
				"thumbnail": "http://tupian.tupianzy.com/pic/upload/vod/2018-10-18/201810181539876671.jpg"
			}
   */
  String id;
  String generatedAt;
  String latest;
  String name;
  String thumbnail;
  
  Hot({ this.id, this.generatedAt, this.latest, this.name, this.thumbnail });

  factory Hot.fromJson(Map<String, dynamic> jsonObj) {
    return Hot(
      id: jsonObj['_id'],
      generatedAt: jsonObj['generated_at'],
      latest: jsonObj['latest'],
      name: jsonObj['name'],
      thumbnail: jsonObj['thumbnail']
    );
  }

}

class Latest {
  /**
   * {
        "_id": "5bc6ec10e6fbb55fe2c62f87",
        "generated_at": "2019-01-01T00:52:02Z",
        "latest": "更新到11集",
        "name": "蔗糖女王第三季",
        "source": "zuidazy",
        "thumbnail": "http://tupian.tupianzy.com/pic/upload/vod/2018-10-17/201810171539757979.jpg"
			}
   */
  String id;
  String generatedAt;
  String latest;
  String name;
  String source;
  String thumbnail;

  Latest({ this.id, this.generatedAt, this.latest, this.name, this.source, this.thumbnail });

  factory Latest.fromJson(Map<String, dynamic> jsonObj) {
    return Latest(
      id: jsonObj['_id'],
      generatedAt: jsonObj['generated_at'],
      latest: jsonObj['latest'],
      name: jsonObj['name'],
      source: jsonObj['source'],
      thumbnail: jsonObj['thumbnail']
    );
  }

}