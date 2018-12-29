/**
 * 首页 Tab Item 组件
 * Create by Songlcy 
 */
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../models/state_model/main_model.dart';

class TabBarComponent extends StatefulWidget {

  final int tabBarIndex;
  final List<String> tabBarIcon;
  final String tabBarText;

  TabBarComponent(this.tabBarIndex, this.tabBarText, this.tabBarIcon);

  @override
  _TabBarComponentState createState() => _TabBarComponentState();
}

class _TabBarComponentState extends State<TabBarComponent> {

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainStateModel>(
      builder: (context, child, model) {
        return Expanded(
          child: Column(
            children: <Widget>[
              Image.asset(
                model.tabBarCurrentIndex == widget.tabBarIndex ? widget.tabBarIcon[1] : widget.tabBarIcon[0], 
                width: 24, 
                height: 24
              ),
              Text(
                widget.tabBarText, 
                style: TextStyle(color: model.tabBarCurrentIndex == widget.tabBarIndex ? Colors.black : Colors.grey)
              )
            ],
          ),
        );
      },
    );
  }
}
