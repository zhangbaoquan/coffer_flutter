/// author       : coffer
/// date         : 2022/10/11
/// description  :
import 'package:flutter/material.dart';
import 'package:flutter_color_plugin/flutter_color_plugin.dart';

void main() {
  runApp(const StatelessUse());
}

class StatelessUse extends StatelessWidget {
  const StatelessUse({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(fontSize: 20);
    return MaterialApp(
      title: 'StatelessWidget 基础组件的学习',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('StatelessWidget 基础组件的学习'),
          leading: GestureDetector(
            onTap: (){
              // 返回上个页面
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back),
          ),
        ),
        body: Container(
          decoration: BoxDecoration(color: Colors.white),
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              Text(
                'I am Text',
                style: textStyle,
              ),
              Icon(
                Icons.android,
                size: 50,
                color: Colors.green,
              ),
              CloseButton(),
              BackButton(),
              Chip(
                // 材料设计中一个非常有趣的标签控件
                avatar: Icon(Icons.people),
                label: Text('Chip 小控件'),
              ),
              Divider(
                height: 10, // 是距离顶部容器的高度，不是线的高度
                indent: 10, // 左侧间距
                color: Colors.orange,
              ),
              Card(
                // 类似于Android的CardView
                color: Colors.yellowAccent,
                elevation: 5,
                margin: EdgeInsets.all(10),
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'I am Card',
                    style: textStyle,
                  ),
                ),
              ),
              AlertDialog(
                title: Text('啦啦啦'),
                content: Text('哈哈哈哈'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
