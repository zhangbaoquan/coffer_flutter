import 'package:flutter/material.dart';

/// author       : coffer
/// date         : 2022/10/15
/// description  : 应用生命周期学习
/// WidgetBindingObserver: 是一个Widgets绑定观察器，通过它我们可以监听应用的生命周期、语言等变化
class AppLifecyclePage extends StatefulWidget {
  const AppLifecyclePage({Key? key}) : super(key: key);

  /// 当我们构建一个新的StatefulWidget 时，这个会立即调用，并且这个方法必须被覆盖
  @override
  _AppLifecyclePageState createState() => _AppLifecyclePageState();
}

class _AppLifecyclePageState extends State<AppLifecyclePage> with WidgetsBindingObserver {

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  /// 这是一个必须实现的方法，在这里实现你要呈现的内容
  /// 它会在didChangeDependencies（）之后立即调用
  /// 另外当调用setState后也会再次调用该方法
  @override
  Widget build(BuildContext context) {
    print('--- build ---');
    return Scaffold(
      appBar: AppBar(
        title: Text('应用生命周期学习'),
        leading: GestureDetector(
          onTap: () {
            // 返回上个页面
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back),
        ),
      ),
      body: Container(
        child: Text('Flutter应用生命周期学习'),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  /// 应用生命周期变化时，会回调该方法
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    print('state : $state ');
    if(state == AppLifecycleState.paused){
      print('应用在后台');
    } else if(state == AppLifecycleState.resumed){
      print('应用在前台');
    }else if(state == AppLifecycleState.inactive){
      // 不常用，应用处于非活跃状态下，并且未接收用户输入时调用，比如：来个电话
    }else if(state == AppLifecycleState.detached){
      print('应用detached');
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

}
