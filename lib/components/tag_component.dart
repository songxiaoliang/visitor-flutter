/**
 * 标签组件
 * Create by Songlcy
 */
import 'package:flutter/material.dart';

class TagComponent extends StatelessWidget {

  final String title;

  const TagComponent({
    this.title = "tag"
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 6.0),
      padding: EdgeInsets.fromLTRB(6.0, 3.0, 6.0, 3.0),
      child: Center(
        child: Text(
          title,
          style: TextStyle(color: Colors.white, fontSize: 10.0),
        ),
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.all(Radius.circular(3.0))
      ),
    );
  }
}
