/// author       : coffer
/// date         : 2022/10/11
/// description  :
import 'dart:ffi';

import 'package:flutter/material.dart';

class AnimateWidgetPage extends StatefulWidget {
  @override
  _AnimateWidgetPageState createState() => _AnimateWidgetPageState();
}

class AnimatedLogo extends AnimatedWidget {
  AnimatedLogo({Key? key, required Animation<double> animation})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable as Animation<double>;
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        height: animation.value,
        width: animation.value,
        child: FlutterLogo(),
      ),
    );
  }
}

class _AnimateWidgetPageState extends State<AnimateWidgetPage>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    // 补间动画
    animation = Tween<double>(begin: 0, end: 300).animate(controller);
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AnimatedWidget 动画 '),
        leading: GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back),
        ),
      ),
      body: AnimatedLogo(animation: animation,),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
