import 'package:coffer_flutter/sample/animate_page.dart';
import 'package:coffer_flutter/sample/drawer_page.dart';
import 'package:coffer_flutter/sample/lala_page.dart';
import 'package:coffer_flutter/sample/lifecycle_widget_page.dart';
import 'package:coffer_flutter/sample/plugin_page.dart';
import 'package:coffer_flutter/sample/res_page.dart';
import 'package:coffer_flutter/sample/stateful_page.dart';
import 'package:coffer_flutter/sample/stateless_page.dart';
import 'package:coffer_flutter/sample/topNavigator_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'animate_page2.dart';
import 'animate_page3.dart';
import 'bottomNavigator_page.dart';
import 'gesture_page.dart';
import 'hero_animate_page1.dart';
import 'layout_page.dart';
import 'lifecycle_app_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool useNightTheme = false;

  // 默认显示日间模式
  Brightness _brightness = Brightness.light;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: _brightness,
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('导航使用'),
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
        'animate3': (BuildContext context) => AnimateBuilderPage(),
        'Hero1': (BuildContext context) => HeroAnimationPage(),
        'TopTab': (BuildContext context) => TabbedAppBarPage(),
        'BottomTab': (BuildContext context) => BottomTabNavigatorPage(),
        'DrawerPage': (BuildContext context) => DrawerPage(),
        // 'launch': (BuildContext context) => LaunchPage(),
      },
    );
  }

  _MainItem() {
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
        const RouterNavigator(),
      ],
    );
  }
}

class RouterNavigator extends StatefulWidget {
  const RouterNavigator({super.key});

  @override
  State<RouterNavigator> createState() => _RouterNavigatorState();
}

class _RouterNavigatorState extends State<RouterNavigator> {
  // true 表示用路由名跳转，false 表示使用Navigator跳转
  bool byName = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SwitchListTile(
            title: Text('${byName ? '' : '不'}通过路由名跳转'),
            value: byName,
            onChanged: (value) {
              setState(() {
                byName = value;
              });
            }),
        Wrap(
          spacing: 10,
          children: [
            _item('插件使用', PluginUse(), 'plugin'),
            _item('资源使用', ResPage(), 'res'),
          ],
        ),
        Wrap(
          spacing: 10,
          children: [
            _item('StatefulUsePage', StatefulUsePage(), 'stateful'),
            _item('StatelessUsePage', StatelessUse(), 'stateless'),
          ],
        ),
        Wrap(
          direction: Axis.horizontal,
          spacing: 10,
          alignment: WrapAlignment.center,
          children: [
            _item('layout', FlutterLayoutPage(), 'layout'),
            _item('手势处理', GesturePage(), 'gesture'),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: _item('组件生命周期', WidgetLifecyclePage(), 'lifecycle'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: _item('应用生命周期', AppLifecyclePage(), 'AppLifecycle'),
            ),
          ],
        ),
        Wrap(
          direction: Axis.horizontal,
          alignment: WrapAlignment.center,
          spacing: 10,
          children: [
            _item('动画', AnimatePage(), 'animate'),
            _item('动画2', AnimateWidgetPage(), 'animate2'),
            _item('动画3', AnimateBuilderPage(), 'animate3'),
            _item('Hero 动画1', HeroAnimationPage(), 'Hero1'),
          ],
        ),
        Wrap(
          spacing: 10,
          children: [
            _item('顶部导航', TabbedAppBarPage(), 'TopTab'),
            _item('底部导航', BottomTabNavigatorPage(), 'BottomTab'),
            _item('侧拉导航', DrawerPage(), 'DrawerPage'),
          ],
        ),
        _item2('哈哈', LalaPage(), 'lala'),
      ],
    );
  }

  _item(String title, page, String routeName) {
    return ElevatedButton(
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
    );
  }

  _item2(String title, page, String routeName) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      transform: Matrix4.rotationZ(.2),
      width: 80,
      height: 50,
      child: DecoratedBox(
        decoration: BoxDecoration(
            gradient:
                LinearGradient(colors: [Colors.red, Colors.orange.shade700]),
            // 渐变
            borderRadius: BorderRadius.circular(3),
            boxShadow: const [
              // 阴影
              BoxShadow(
                  color: Colors.black54,
                  offset: Offset(2.0, 2.0),
                  blurRadius: 4.0)
            ]),
        child: Center(
          child: GestureDetector(
            onTap: () {
              // true 表示用路由名跳转，false 表示使用Navigator跳转
              if (byName) {
                Navigator.pushNamed(context, routeName);
              } else {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => page));
              }
            },
            child: Transform.scale(scale: 1.5, child: Text(title)),
          ),
        ),
      ),
    );
  }
}
