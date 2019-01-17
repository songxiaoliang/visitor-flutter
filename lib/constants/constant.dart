final List<String> tabTitle = ["首页", "精选", "电影", "我"];
final List<List<String>> tabIcon = [
  [
    "assets/images/icon_home_tab.png",
    "assets/images/icon_home_tab_pressed.png"
  ],
  [
    "assets/images/icon_popular_tab.png",
    "assets/images/icon_popular_tab_pressed.png"
  ],
  [
    "assets/images/icon_movie_tab.png",
    "assets/images/icon_movie_tab_pressed.png"
  ],
  ["assets/images/icon_mine_tab.png", "assets/images/icon_mine_tab_pressed.png"]
];

final List<List<Map>> FILTER_ITEM = [
  [
    {"title": "不限年代", "key": "year", "value": ""},
    {"title": "2019", "key": "year", "value": "2018"},
    {"title": "2018", "key": "year", "value": "2018"},
    {"title": "2017", "key": "year", "value": "2017"},
    {"title": "2016", "key": "year", "value": "2016"},
    {"title": "2015", "key": "year", "value": "2015"},
    {"title": "2014", "key": "year", "value": "2014"},
    {"title": "2013", "key": "year", "value": "2013"},
    {"title": "2012", "key": "year", "value": "2012"},
    {"title": "2011", "key": "year", "value": "2011"},
    {"title": "2010", "key": "year", "value": "2010"},
    {"title": "00年代", "key": "year", "value": "00"},
    {"title": "更早", "key": "year", "value": "更早"},
  ],
  [
    {"title": "不限地区", "key": "area", "value": ""},
    {"title": "大陆", "key": "area", "value": "大陆"},
    {"title": "香港", "key": "area", "value": "香港"},
    {"title": "台湾", "key": "area", "value": "台湾"},
    {"title": "日本", "key": "area", "value": "日本"},
    {"title": "韩国", "key": "area", "value": "韩国"},
    {"title": "美国", "key": "area", "value": "美国"},
    {"title": "法国", "key": "area", "value": "法国"},
    {"title": "德国", "key": "area", "value": "德国"},
    {"title": "英国", "key": "area", "value": "英国"},
    {"title": "其他", "key": "area", "value": "其他"},
  ],
  [
    {"title": "不限来源", "key": "source", "value": ""},
    {"title": "最大资源网", "key": "source", "value": "zuidazy"},
    {"title": "酷云资源网", "key": "source", "value": "kuyunzy"}
  ],
  [
    {"title": "最新收录", "key": "sort", "value": "1"},
    {"title": "最新上映", "key": "sort", "value": "2"},
    {"title": "最多播放", "key": "sort", "value": "3"},
  ],
];
