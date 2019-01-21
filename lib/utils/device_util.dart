/**
 * 屏幕工具类
 * Create by Songlcy
 */
import 'dart:ui';
import 'package:flutter/material.dart';

class DeviceUtil {

  /**
   * window, 单位px
   */
  final double SCREEN_WIDTH = window.physicalSize.width;
  final double SCREEN_HEIGHT = window.physicalSize.height;
  final double SCREEN_PIXEL_RATIO = window.devicePixelRatio; 
  final double TEXT_SCALE_FACTOR = window.textScaleFactor;


  // ====== 以下为MediaQuery属性，单位dp ======

  /**
   * 屏幕尺寸, 单位为dp
   */
  static Size getScreenSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  /**
   * 屏幕像素密度
   */
  static double getDevicePixelRatio(BuildContext context) {
    return MediaQuery.of(context).devicePixelRatio;
  }

  /**
   * 获取上边距和下边距的值。(主要用于刘海屏)
   */
  static double topPadding(BuildContext context) {
    return MediaQuery.of(context).padding.top;
  }

  static double bottomPadding(BuildContext context) {
    return MediaQuery.of(context).padding.bottom;
  }

  /**
   * 每个逻辑像素的字体像素数。 默认为1.0
   */
  static double getTextScaleFactor (BuildContext context) {
    return MediaQuery.of(context).textScaleFactor;
  }

}