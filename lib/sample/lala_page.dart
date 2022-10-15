/// author       : coffer
/// date         : 2022/10/11
/// description  :
import 'package:flutter/material.dart';
import 'package:flutter_color_plugin/flutter_color_plugin.dart';

class LalaPage extends StatefulWidget {
  @override
  _LalaPageState createState() => _LalaPageState();
}

class _LalaPageState extends State<LalaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('嘿嘿'),
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ClipOval(
              child: SizedBox(
                width: 100,
                height: 100,
                child: Image.network(
                  'http://www.devio.org/img/avatar.png',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 30),
              child: Column(
                children: [
                  Text(
                    '我是iPad ，从此我就是你的调试机，忘了Android 机吧',
                    style: TextStyle(fontSize: 36),
                  ),
                ],
              ),
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
