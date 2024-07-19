import 'dart:html';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// author       : coffer
/// date         : 2023/3/7
/// description  :
class LalaController extends GetxController {
  int counter = 0;
  var count = 0.obs;

  void increment() {
    counter++;
    update(); // 当调用增量时，使用update()来更新用户界面上的计数器变量。
  }

  @override
  void onInit() {
    print("$this onReady");
    super.onInit();
  }

  @override
  void onReady() {
    print("$this onReady");
    super.onReady();
  }

  @override
  void onClose() {
    print("$this onClose");
    super.onClose();
  }
}

class NaNaa extends GetView{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

}

class Lala extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LalaController>(builder: (logic) {
      // return Text(
      //   '点击了 ${logic.count} 次',
      //   style: TextStyle(fontSize: 30.0),
      // );
      return Obx((){
        Get.put(LalaController(),tag: "LalaController");
        Get.put("kk",tag: "LalaController");
        Get.delete(tag: "LalaController");
        return Text(
          '点击了 ${logic.count} 次',
          style: const TextStyle(fontSize: 30.0),
        );
      });
    },assignId: true,);
  }

}

mixin Man {
  late String name;
  late int age;

  void setManInfo(String name, int age) {
    this.name = name;
    this.age = age;
  }

  getAge() {
    return age;
  }
}

class Body {
  late String head;

  Body(this.head);

  void go() {
    print("$this go");
  }
}

class NaNa implements Body {
  @override
  void go() {
    // TODO: implement go
  }

  @override
  String head = "nana";
}

class LaLa extends Body with Man {
  LaLa() : super('') {
    setManInfo("lala", 20);
  }

  @override
  void go() {
    print("age : $getAge");
  }
}

extension StringExt on String{
  String kaka(){
    print('hehe');
    return "我是扩展方法";
  }
}

class HeHe{
  void lulu(){
    print("lulu".kaka());
  }
}

class Manager{

  /// 静态私有成员
  static Manager? instance;

  /// 单例公开访问点
  factory Manager() => instance ??= Manager._();

  /// 私有化构造方法
  Manager._();

  String getName(){
    return 'lala';
  }
}
