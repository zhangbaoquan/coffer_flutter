import 'package:coffer_flutter/sample/animate_page.dart';
import 'package:coffer_flutter/sample/lala_page.dart';
import 'package:coffer_flutter/sample/lifecycle_widget_page.dart';
import 'package:coffer_flutter/sample/plugin_page.dart';
import 'package:coffer_flutter/sample/res_page.dart';
import 'package:coffer_flutter/sample/stateful_page.dart';
import 'package:coffer_flutter/sample/stateless_page.dart';
import 'package:flutter/material.dart';

import 'animate_page2.dart';
import 'gesture_page.dart';
import 'layout_page.dart';
import 'lifecycle_app_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool useNightTheme = false;

  // 默认显示日间模式
  Brightness _brightness = Brightness.light;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          brightness: _brightness,
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: Text('导航使用'),
          ),
          body: _MainItem(),
        ),
        routes: <String, WidgetBuilder>{
          'plugin': (BuildContext context) => PluginUse(),
          'stateful': (BuildContext context) => StatefulUsePage(),
          'stateless': (BuildContext context) => StatelessUse(),
          'layout': (BuildContext context) => FlutterLayoutPage(),
          'gesture': (BuildContext context) => GesturePage(),
          'res': (BuildContext context) => ResPage(),
          'lala': (BuildContext context) => LalaPage(),
          'lifecycle': (BuildContext context) => WidgetLifecyclePage(),
          'AppLifecycle': (BuildContext context) => AppLifecyclePage(),
          'animate': (BuildContext context) => AnimatePage(),
          'animate2': (BuildContext context) => AnimateWidgetPage(),
          // 'launch': (BuildContext context) => LaunchPage(),
        },
      ),
    );
  }

  _MainItem(){
    return Column(
      children: [
        SwitchListTile(
            title: Text('当前是 ： ${useNightTheme ? '夜间模式' : '日间模式'}主题'),
            value: useNightTheme,
            onChanged: (value) {
              setState(() {
                if (value) {
                  _brightness = Brightness.dark;
                } else {
                  _brightness = Brightness.light;
                }
                useNightTheme = value;
              });
            }),
        RouterNavigator(),
      ],
    );
  }
}

class RouterNavigator extends StatefulWidget {
  @override
  State<RouterNavigator> createState() => _RouterNavigatorState();
}

class _RouterNavigatorState extends State<RouterNavigator> {
  // true 表示用路由名跳转，false 表示使用Navigator跳转
  bool byName = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SwitchListTile(
              title: Text('${byName ? '' : '不'}通过路由名跳转'),
              value: byName,
              onChanged: (value) {
                setState(() {
                  byName = value;
                });
              }),
          _item('插件使用', PluginUse(), 'plugin'),
          _item('StatefulUsePage', StatefulUsePage(), 'stateful'),
          _item('StatelessUsePage', StatelessUse(), 'stateless'),
          _item('layout', FlutterLayoutPage(), 'layout'),
          _item('手势处理', GesturePage(), 'gesture'),
          _item('资源使用', ResPage(), 'res'),
          _item('组件生命周期', WidgetLifecyclePage(), 'lifecycle'),
          _item('应用生命周期', AppLifecyclePage(), 'AppLifecycle'),
          _item('动画', AnimatePage(), 'animate'),
          _item('动画2', AnimateWidgetPage(), 'animate2'),
          _item('哈哈', LalaPage(), 'lala'),
          // _item('开启三方应用', LaunchPage(),'launch'),
        ],
      ),
    );
  }

  _item(String title, page, String routeName) {
    return Container(
      child: ElevatedButton(
        onPressed: () {
          // true 表示用路由名跳转，false 表示使用Navigator跳转
          if (byName) {
            Navigator.pushNamed(context, routeName);
          } else {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => page));
          }
        },
        child: Text(title),
      ),
    );
  }
}

