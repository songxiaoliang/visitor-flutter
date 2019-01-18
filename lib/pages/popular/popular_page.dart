/**
 * 精选
 * Create by Songlcy
 */
import 'package:flutter/material.dart';

import './popular_tab_page.dart';
import '../../components/tabbar_indictor_component.dart';

class PopularPage extends StatefulWidget {

  @override
  _PopularPageState createState() => _PopularPageState();
}

class _PopularPageState extends State<PopularPage> with SingleTickerProviderStateMixin {

  TabController _tabController;
  final List _tabBarList = [ 
    {"id": "5b1fdbee30025ae5371ac363", "name": "动漫"}, 
    {"id": "5b1fd85730025ae5371abaed", "name": "综艺"}
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            floating: true,
            pinned: true,
            centerTitle: true,
            title: Text("Popular", style: TextStyle(fontFamily: "Lobster")),
            backgroundColor: Theme.of(context).primaryColor,
            bottom: PreferredSize(
              preferredSize: Size(double.infinity, 36.0),
              child: Container(
                height: 36.0,
                child: TabBar(
                  controller: _tabController,
                  labelColor: Colors.white,
                  unselectedLabelColor: Color.fromARGB(255,192, 193, 195),
                  indicator: TabBarIndictorComponent(context: context),
                  tabs: <Widget>[
                    Tab(text: "动漫"),
                    Tab(text: "综艺")
                  ],
                ),
              ),
            ),
          )
        ];
      },
      body: TabBarView(
        controller: _tabController,
        children:_tabBarList.map((item) => PopularTabPage(id: item["id"])).toList()
      ),
    );
  }
}