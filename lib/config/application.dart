/**
 * 全局应用
 * Create by Songlcy
 */
import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:event_bus/event_bus.dart';

class Application {
  static Router router;
  static EventBus eventBus; 

  static navigateTo({ @required BuildContext context, @required String route, transition = TransitionType.inFromRight }) {
    router.navigateTo(context, route, transition: transition);
  }
}

