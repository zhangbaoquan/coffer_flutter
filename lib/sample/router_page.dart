import 'package:coffer_flutter/sample/res_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp

  ({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('导航使用'),
        ),
        body: RouterNavigator(),
      ),
      routes: <String, WidgetBuilder>{
        // 'plugin': (BuildContext context) => PluginUse(),
        // 'stateful': (BuildContext context) => StatefulUsePage(),
        // 'stateless': (BuildContext context) => StatelessUse(),
        // 'layout': (BuildContext context) => FlutterLayoutPage(),
        // 'gesture': (BuildContext context) => GesturePage(),
        'res': (BuildContext context) => ResPage(),
        // 'launch': (BuildContext context) => LaunchPage(),
      },
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
        title: Text('${byName?'':'不'}通过路由名跳转'),
        value: byName,
        onChanged: (value) {
          setState(() {
            byName = value;
          });
        }),
    // _item('插件使用', PluginUse(), 'plugin'),
    // _item('StatefulUsePage', StatefulUsePage(),'stateful'),
    // _item('StatelessUsePage', StatelessUse(),'stateless'),
    // _item('layout', FlutterLayoutPage(),'layout'),
    // _item('手势处理', GesturePage(),'gesture'),
    _item('资源使用', ResPage(),'res'),
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
          if(byName){
            Navigator.pushNamed(context, routeName);
          }else{
            Navigator.push(context, MaterialPageRoute(builder: (context) => page));
          }
        },
        child: Text(title),
      ),
    );
  }
}
