/**
 * TabBar导航自定义指示器
 * Create by Songlcy 
 */
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TabBarIndictorComponent extends Decoration {

  @override
  BoxPainter createBoxPainter([onChanged]) => _TabBarIndictorBoxPainter();
}

class _TabBarIndictorBoxPainter extends BoxPainter {
  
  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final Paint paint = Paint();
    paint.color = Color.fromARGB(255, 51, 51, 51);
    paint.style = PaintingStyle.fill;
    final width = 30.0;
    final height = 2.0;
    canvas.drawRect(
      Rect.fromLTWH(offset.dx - width / 2 + configuration.size.width / 2,
        configuration.size.height - height, width, height), 
      paint
    );
  }
}