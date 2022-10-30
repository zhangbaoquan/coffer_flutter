/// author       : coffer
/// date         : 2022/10/11
/// description  :
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesPage extends StatefulWidget {
  @override
  _SharedPreferencesPageState createState() => _SharedPreferencesPageState();
}

class _SharedPreferencesPageState extends State<SharedPreferencesPage> {
  String countString = '';
  String localCount = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('本地存储练习：计算器'),
        leading: GestureDetector(
          onTap: () {
            // 返回上个页面
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(onPressed: () {
              _incrementCounter();
            }, child: const Text('Increment Counter')),
            ElevatedButton(onPressed: () {
              _getCounter();
            }, child: const Text('Get Counter')),
            Text(
              countString,
              style: const TextStyle(fontSize: 20),
            ),
            Text(
              'result：$localCount',
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  _incrementCounter() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      countString = '$countString 1';
    });
    // 如果获取数据不存在，则返回0，否则 +1
    int counter = (preferences.getInt('counter') ?? 0) + 1;
    await preferences.setInt('counter', counter);
  }

  _getCounter() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      localCount = sharedPreferences.getInt('counter').toString();
    });
  }
}
