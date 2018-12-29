/**
 * 我
 */
import 'package:flutter/material.dart';

class MinePage extends StatefulWidget {

  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {

  @override
    Widget build(BuildContext context) {
       return Scaffold(
        appBar: AppBar(
          title: Text("1"),
        ),
        body: Center(
          child: Text("2"),
        ),

      );
    }
}