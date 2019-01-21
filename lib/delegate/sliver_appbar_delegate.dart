/**
 * SliverPersistentHeader 委托类
 */
import 'package:flutter/material.dart';

class SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  
  final TabBar _tabBar;
  SliverAppBarDelegate(this._tabBar);

  /**
   * minExtent 与 maxExtent 相同, Header不会有收缩效果，类似普通Header。
   */
  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      child: _tabBar
    );
  }

  @override
  bool shouldRebuild(SliverAppBarDelegate oldDelegate) {
    return false;
    // return maxHeight != oldDelegate.maxHeight ||
    //   minHeight != oldDelegate.minHeight ||
    //   child != oldDelegate.child;
  }
}