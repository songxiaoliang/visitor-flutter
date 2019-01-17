/**
 * 过滤器组件状态Model
 * Create by Songlcy
 */
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import './base_state_model.dart';
import './movie_state_model.dart';
import '../../constants/constant.dart';

/**
 * item下标状态
 */
class FilterBarIndexState {
  final int yearIndex; // 年份
  final int areaIndex; // 地区
  final int sortIndex; // 最新收录
  final int sourceIndex; // 来源

  FilterBarIndexState({
    this.yearIndex = 0,
    this.areaIndex = 0,
    this.sortIndex = 1,
    this.sourceIndex = 0,
  });
}

class FilterStateModel extends BaseStateModel with MovieStateModel {

  bool _isOpen = false;
  List<Map> _itemList = [];
  FilterBarIndexState _filterBarIndexState;
  FilterStateModel(this._filterBarIndexState);

  bool get isOpen => _isOpen;
  List<Map> get itemList => _itemList;

  void init() {
    _itemList = [
      {"index": _filterBarIndexState.yearIndex, "data": FILTER_ITEM[0]},
      {"index": _filterBarIndexState.areaIndex, "data": FILTER_ITEM[1]},
      {"index": _filterBarIndexState.sourceIndex, "data": FILTER_ITEM[2]},
      {"index": _filterBarIndexState.sortIndex, "data": FILTER_ITEM[3]},
    ];
  }

  void setSelectIndex(int groupIndex, int index) {
    _itemList[groupIndex]["index"] = index;
    notifyListeners();
  }

  void toggleOpenStatus() {
    _isOpen = !_isOpen;
    notifyListeners();
  }

  static FilterStateModel of(BuildContext context) => ScopedModel.of<FilterStateModel>(context, rebuildOnChange: true);
}
