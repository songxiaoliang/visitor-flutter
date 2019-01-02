/**
 * 首页Tab分类实体类
 * Create by Songlcy
 */

class IndexTabModel {
  
  String id;
  String name;
  
  IndexTabModel({ this.id, this.name });

  factory IndexTabModel.fromJson(Map<String, dynamic> jsonObj) {
    return new IndexTabModel(
      id: jsonObj["_id"], 
      name: jsonObj["name"]
    );
  }
}