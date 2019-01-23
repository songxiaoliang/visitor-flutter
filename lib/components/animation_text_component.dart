/**
 * 动画Text组件
 * Create by Songlcy
 */
import 'package:flutter/material.dart';

class AnimationTextComponent extends StatefulWidget {
  final String text;
  final TextStyle textStyle;

  final int duration;
  final int delayTime;

  const AnimationTextComponent({
    this.text = "",
    this.textStyle = const TextStyle(color: Colors.black),
    this.duration = 1000,
    this.delayTime = 0
  });

  @override
  State<StatefulWidget> createState() => _AnimationTextComponentState();
}

class _AnimationTextComponentState extends State<AnimationTextComponent> with SingleTickerProviderStateMixin {

  String showText;
  String hideText;
  Animation<int> animation;
  AnimationController animationContainer;
  
  @override
  void initState() {
    super.initState();

    animationContainer = AnimationController(
      vsync: this, 
      duration: Duration(microseconds: widget.duration)
    );

    animation = IntTween(
      begin: 0, 
      end: widget.text.length
    ).animate(CurvedAnimation(parent: animationContainer, curve: Curves.easeIn));

    animation.addListener((){
      // 刷新text
      setState(() {
        showText = widget.text.substring(0, animation.value);
        hideText = widget.text.substring(animation.value, widget.text.length);
      });
    });

    Future.delayed(Duration(microseconds: widget.delayTime), (){
      animationContainer.forward(from: 0.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
      maxLines: 10,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(text: showText, style: widget.textStyle),
          TextSpan(text: hideText, style: widget.textStyle.copyWith(color: Colors.transparent))
        ]
      ),
    );
  }
}
