/**
 * 列表底部组件
 * Create by Songlcy
 */
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../common/status.dart';
import './empty_component.dart';

 
class ListBottomIndicator extends StatelessWidget {

  final Status status;
  final Function onPressCallback;
  ListBottomIndicator({ @required this.status, @required this.onPressCallback });

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case Status.LOADING:
        // 加载中
        return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // CircularProgressIndicator(
              //   strokeWidth: 2,
              //   valueColor: AlwaysStoppedAnimation<Color>(
              //       Theme.of(context).primaryColor)),
               SpinKitFadingCircle(
                size: 30.0,
                itemBuilder: (_, int index) {
                  return DecoratedBox(
                    decoration: BoxDecoration(
                      color: index.isEven ? Colors.red : Colors.green,
                    ),
                  );
                },
              ),
              Container(
                margin: EdgeInsets.only(left: 15.0),
                child: Text(
                  "客官不要急, 正在路上...", 
                  style: TextStyle(color: Color.fromARGB(255,192, 193, 195))),
              )
            ],
          );
        break;
      case Status.ERROR:
        return Padding(
          padding: EdgeInsets.only(left: 20.0, top: 10.0, right: 20.0),
          child: MaterialButton(
            color: Theme.of(context).primaryColor,
            child: Text("加载失败，重新加载", style: TextStyle(color: Colors.white)),
            onPressed: () => onPressCallback(),
          ),
        );
      case Status.NO_RESULT:
        return Center(
          child: Text("未发现符合搜索条件的数据...",
              style: TextStyle(color: Theme.of(context).primaryColor)),
        );
      case Status.NO_MORE:
        return Center(
          child: Text("--我也是有底线的--",
              style: TextStyle(color: Theme.of(context).primaryColor)),
        );
      default:
        return EmptyComponent();
        break;
    }
  }
}