/**
 * 首页
 * Create by Songlcy 2018-12-25
 */
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../models/state_model/home_state_model.dart';

import '../index/index_tab_page.dart';
import '../../models/common/status_enum.dart';
import '../../components/loading_component.dart';
import '../../components/data_empty_component.dart';
import '../../components/tabbar_indictor_component.dart';

class IndexPage extends StatefulWidget {

  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> with SingleTickerProviderStateMixin {

  List<Tab> _tabWidgetList = [];
  TabController _tabController;

  HomeStateModel homeStateModel;

  _getIndexModel() {
    if(homeStateModel == null) {
      homeStateModel = HomeStateModel();
    }
    return homeStateModel;
  }

  @override
  void initState() {
    super.initState();
    _getIndexModel();
   _initTabBarController();
  }

  void _initTabBarController() async {
    await homeStateModel.fetchTabList();
    _tabController = new TabController(vsync: this, length: homeStateModel.tabList.length);
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<HomeStateModel>(
      model: homeStateModel,
      child: ScopedModelDescendant<HomeStateModel>(
        builder: (context, child, model) {
            return Scaffold(
            body: _renderBody(model),
          );
        },
      ),
    );
  }

  /**
   * 内容
   */
  _renderBody(HomeStateModel model) {
    return model.status == Status.LOADING ? 
    LoadingComponent()
    :
    model.status == Status.SUCCESS ? 
    _renderTabView(model)
    :
    DataEmptyComponent(status: model.status);
  }

  /**
   * TabView
   */
  _renderTabView(HomeStateModel model) {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      width: double.infinity,
      child: Column(
        children: <Widget>[
          _renderTabBar(model),
          _renderTabBarView(model)
        ],
      ),
    );
  }

  /**
   * 顶部TabBar选项
   */
  _renderTabBar(HomeStateModel model) {
    return Container(
      width: double.infinity,
      height: 60.0,
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TabBar(
              tabs: model.tabList.map<Tab>((tab) => Tab(text: tab.name)).toList(),
              isScrollable: true,
              labelColor: Color.fromARGB(255, 51, 51, 51),
              unselectedLabelColor: Color.fromARGB(255,192, 193, 195),
              indicator: TabBarIndictorComponent(context: context),
              controller: _tabController,
            ),
          ),
        ],
      ),
    );
  }

  /**
   * TabBar视图
   */
  _renderTabBarView(HomeStateModel model) {
    return Expanded(
      child: TabBarView(
        controller: _tabController,
        children: model.tabList.map<Widget>((tab) => IndexTabPage(name: tab.name ,categoryId: tab.id, stateModel: model)).toList()
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }
}


