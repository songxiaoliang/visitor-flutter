/**
 * 空视图组件
 * Create by Songlcy 
 */
import 'package:flutter/material.dart';

class EmptyComponent extends StatelessWidget {

  const EmptyComponent();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 0,
      height: 0,
    );
  }
}
