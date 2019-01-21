/**
 * 首页 Tab 界面
 * Create by Songlcy
 */
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../models/state_model/home_state_model.dart';
import '../../components/data_empty_component.dart';
import '../../components/loading_component.dart';
import '../../common/status.dart';
import '../../models/pood/index_tab_page_model.dart';

class IndexTabPage extends StatefulWidget {

  String name;
  String categoryId;
  HomeStateModel stateModel;

  IndexTabPage({this.name, @required this.categoryId, @required this.stateModel});

  @override
  _IndexTabPageState createState() => _IndexTabPageState();
}

class _IndexTabPageState extends State<IndexTabPage>
    with AutomaticKeepAliveClientMixin<IndexTabPage> {
      
  @override
  void initState() {
    super.initState();
    print(widget.name);
    widget.stateModel.fetchIndexVideoList(widget.categoryId);
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<HomeStateModel>(
      builder: (context, child, model) {
        return _renderBody(model);
      },
    );
  }

  /**
   * 内容
   */
  _renderBody(HomeStateModel model) {
    return model.status == Status.LOADING
        ? LoadingComponent()
        : model.status == Status.SUCCESS
            ? _renderListView(model.hotMap[widget.categoryId])
            : DataEmptyComponent(status: model.status);
  }

  _renderListView(List<Hot> list) {
    if(list != null) {
      return ListView.builder(
        key: PageStorageKey(widget.categoryId),
        itemBuilder: (BuildContext context, int index) => _ItemComponent(itemData: list[index]),
        itemCount: list.length,
      );
    } 
    return Text("123");
  }
}

class _ItemComponent extends StatelessWidget {
  Hot itemData;
  _ItemComponent({this.itemData});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 20,
      margin: EdgeInsets.all(10),
      child: Stack(
        children: <Widget>[
          Image.network(itemData.thumbnail,
              width: MediaQuery.of(context).size.width - 20, height: 200.0, repeat: ImageRepeat.repeat, fit: BoxFit.cover)
        ],
      ),
    );
  }
}
