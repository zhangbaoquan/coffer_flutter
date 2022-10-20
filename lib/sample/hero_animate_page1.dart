/// author       : coffer
/// date         : 2022/10/11
/// description  :
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class PhotoHero extends StatelessWidget {
  final String photo;
  final VoidCallback onTap;
  final double width;

  const PhotoHero(
      {Key? key, required this.photo, required this.onTap, required this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: SizedBox(
      width: width,
      child: Hero(
        tag: photo,//tag：[必须]用于关联两个Hero动画的标识；
        child: Material(  // child：[必须]定义动画所呈现的widget；
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: Image.network(
              photo,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    ));
  }
}

class HeroAnimationPage extends StatelessWidget {
  const HeroAnimationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    timeDilation = 5.0; // 1.0 means normal animation speed.
    return Scaffold(
      appBar: AppBar(
        title: Text('Hero动画'),
        leading: GestureDetector(
          onTap: () {
            // 返回上个页面
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back),
        ),
      ),
      body: PhotoHero(
        photo:
            'https://raw.githubusercontent.com/flutter/website/master/examples/_animation/hero_animation/images/flippers-alpha.png',
        width: 300.0,
        onTap: () {
          // 执行页面跳转
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Flippers Page'),
              ),
              body: Container(
                color: Colors.lightBlueAccent,
                padding: EdgeInsets.all(16),
                alignment: Alignment.topLeft,
                child: PhotoHero(
                  photo: 'https://raw.githubusercontent.com/flutter/website/master/examples/_animation/hero_animation/images/flippers-alpha.png',
                  width: 100.0,
                  onTap: (){
                    Navigator.of(context).pop();
                  },key: null,
                ),
              ),
            );
          }));
        },
      ),
    );
  }
}
