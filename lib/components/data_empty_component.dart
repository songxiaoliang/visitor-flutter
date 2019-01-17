/**
 * 加载结果视图组件（数据为空，加载失败）
 * Create by Songlcy 
 */
import 'package:flutter/material.dart';
import '../common/status.dart';

class DataEmptyComponent extends StatelessWidget {

  Status status = Status.READY;

  DataEmptyComponent({ @required this.status });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _renderBody(status)
    );
  }

  _renderBody(Status status) {
    return status == Status.NO_RESULT ? _renderNoResultView() : _renderErrorComponent();
  }

  /**
   * 无数据
   */
  _renderNoResultView() {
    return Column(
      children: <Widget>[
        Image.asset("assets/images/icon_empty.webp",
          width: 160.0,
          height: 100.0,
          fit: BoxFit.cover  
        ),
      ],
    );
  }

  /**
   * 加载失败
   */
  _renderErrorComponent() {
     return Column(
      children: <Widget>[
        Image.asset("assets/images/icon_load_error.png",
          width: 60.0,
          height: 60.0,
          fit: BoxFit.cover  
        ),
        Container(
          margin: EdgeInsets.only(top: 10.0),
          child: Text("加载失败,请检查网络连接", style:TextStyle(color: Colors.grey)),
        )
      ],
    );
  }
}
