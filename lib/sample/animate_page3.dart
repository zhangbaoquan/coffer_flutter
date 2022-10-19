/// author       : coffer
/// date         : 2022/10/11
/// description  :
import 'dart:ffi';

import 'package:flutter/material.dart';

class AnimateBuilderPage extends StatefulWidget {
  @override
  _AnimateBuilderPageState createState() => _AnimateBuilderPageState();
}

class LogWidget extends StatelessWidget {
  const LogWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: FlutterLogo(),
    );
  }
}

class GrowTransition extends StatelessWidget {
  late Widget child;
  late Animation<double> animation;

  GrowTransition({required this.child,required this.animation});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: animation,
        builder: (context, child) => Container(
          height: animation.value,
          width: animation.value,
          child: child,
        ),
      child: child,
    );
  }
}

class _AnimateBuilderPageState extends State<AnimateBuilderPage>
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
      body: GrowTransition(animation: animation,child: LogWidget(),),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
