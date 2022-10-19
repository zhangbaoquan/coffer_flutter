/// author       : coffer
/// date         : 2022/10/11
/// description  :
import 'dart:ffi';

import 'package:flutter/material.dart';

class AnimatePage extends StatefulWidget {
  @override
  _AnimatePageState createState() => _AnimatePageState();
}

class _AnimatePageState extends State<AnimatePage>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;
  late AnimationStatus? animationStatus = null;
  double animationValue = 0;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    // 补间动画
    animation = Tween<double>(begin: 0, end: 300).animate(controller);
    animation.addListener(() {
      // 动画每次变动都会执行到这里，这里可以获取并更新动画的值
      setState(() {
        animationValue = animation.value;
      });
    });
    animation.addStatusListener((AnimationStatus status) {
      // 获取动画的状态
      setState(() {
        animationStatus = status;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('动画'),
        leading: GestureDetector(
          onTap: () {
            // 返回上个页面
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
                padding: EdgeInsets.only(top: 30, bottom: 30),
                child: ElevatedButton(
                    onPressed: () {
                      controller.reset();
                      controller.forward();
                    },
                    child: Text(
                      'Start',
                      textDirection: TextDirection.ltr,
                    ))),
            Text(
              'State : ' + animationStatus.toString(),
              textDirection: TextDirection.ltr,
            ),
            Text(
              'Value : ' + animationValue.toString(),
              textDirection: TextDirection.ltr,
            ),
            Container(
              width: animation.value,
              height: animation.value,
              child: FlutterLogo(),
            )
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
