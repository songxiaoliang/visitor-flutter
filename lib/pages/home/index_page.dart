/**
 * 首页
 * Create by Songlcy 2018-12-25
 */
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../models/state_model/main_model.dart';

class IndexPage extends StatefulWidget {

  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainStateModel>(
      builder: (context, child, model) {
        return Scaffold(
        appBar: AppBar(
          title: Text("1"),
        ),
        body: Center(
          child: Text("2"),
        ),

      );
      },
    );
  }
}


