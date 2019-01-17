/**
 * 过滤菜单
 * Create by Songlcy
 */
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../models/state_model/filter_state_model.dart';

class FilterBarComponent extends StatefulWidget {

  final Function onItemSelectCallback; // item 选择回调
  final int itemNums; // item 分组数

  FilterBarComponent({
    Key key,
    @required this.itemNums,
    @required this.onItemSelectCallback
  }): super(key: key);

  @override
  State<StatefulWidget> createState() => _FilterBarComponentState();
}

class _FilterBarComponentState extends State<FilterBarComponent> {

  final Duration animatedDuration = Duration(milliseconds: 300); // 动画执行时长
  final double FILTER_BAR_ITEM_HEIGHT = 50.0; //  item 高度
  double filterBarHeight = 0; //  整个过滤菜单栏高度

  @override
  void initState() {
    super.initState();
    filterBarHeight = widget.itemNums * FILTER_BAR_ITEM_HEIGHT;
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<FilterStateModel>(
      builder: (context, child, model) {
      return AnimatedContainer(
        duration: animatedDuration,
        height: model.isOpen ? filterBarHeight : FILTER_BAR_ITEM_HEIGHT,
        child: Wrap(
          children: List.generate(model.itemList.length, (index) {
            return FilterGroupComponent(
              groupIndex: index,
              currentIndex: model.itemList[index]["index"],
              filterItemList: model.itemList[index]["data"],
              onItemSelectCallback: widget.onItemSelectCallback
            );
          }
        )
      ));
    });
  }
}

/**
 * 过滤项组
 */
class FilterGroupComponent extends StatelessWidget {
  final int groupIndex;
  final int currentIndex;
  final List<Map> filterItemList;
  final double filterItemHeight;
  final Function onItemSelectCallback;

  FilterGroupComponent({
    this.groupIndex,
    @required this.currentIndex,
    @required this.filterItemList,
    @required this.onItemSelectCallback,
    this.filterItemHeight = 50.0
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: filterItemHeight,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: List.generate(filterItemList.length, (index) {
          return FilterItemComponent(
            groupIndex: groupIndex,
            itemIndex: index,
            filterItem: filterItemList[index],
            filterItemHeight: filterItemHeight,
            currentIndex: currentIndex,
            onItemSelectCallback: onItemSelectCallback);
        }),
      ),
    );
  }
}

/**
 * 过滤项
 */
class FilterItemComponent extends StatelessWidget {
  final double filterItemHeight;
  final Map filterItem;
  final int groupIndex;
  final int itemIndex;
  final int currentIndex;
  final Function onItemSelectCallback;
  FilterItemComponent({
    this.groupIndex,
    this.itemIndex,
    @required this.filterItem,
    this.filterItemHeight,
    @required this.currentIndex,
    @required this.onItemSelectCallback
  });

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<FilterStateModel>(
      builder: (context, child, model) {
        return Container(
          margin: EdgeInsets.all(5.0),
          child: Material(
            child: InkWell(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 5.0),
                height: filterItemHeight - 10.0,
                child: Center(
                  child: Text(
                    filterItem["title"],
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: currentIndex == itemIndex
                            ? Colors.white
                            : Colors.black12),
                  ),
                ),
                decoration: BoxDecoration(
                  color: currentIndex == itemIndex
                      ? Theme.of(context).primaryColor
                      : Colors.transparent,
                  borderRadius: BorderRadius.all(Radius.circular(5.0))),
              ),
            onTap: () {
              model.setSelectIndex(groupIndex, itemIndex);
              onItemSelectCallback(filterItem); // 点击回调
            },
          ),
          type: MaterialType.transparency,
        ));
      },
    );
  }
}
