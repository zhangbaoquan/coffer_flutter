/// author       : coffer
/// date         : 2022/10/11
/// description  :
import 'package:flutter/material.dart';
import 'package:flutter_color_plugin/flutter_color_plugin.dart';

void main() {
  runApp(StatefulUsePage());
}

class StatefulUsePage extends StatefulWidget {
  @override
  _StateFullUseGroupState createState() => _StateFullUseGroupState();
}

class _StateFullUseGroupState extends State<StatefulUsePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StatefulWidget 基础组件的学习',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('StatefulWidget 基础组件的学习'),
          leading: GestureDetector(
            onTap: (){
              // 返回上个页面
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              // 设置选中的index，更新选中状态
              _currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              activeIcon: Icon(
                Icons.home,
                color: Colors.blue,
              ),
              label: '首页',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              activeIcon: Icon(
                Icons.list,
                color: Colors.blue,
              ),
              label: '列表',
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: null,
          child: Text('点我'),
        ),
        body: _currentIndex == 0
            ? RefreshIndicator(
                // 下拉刷新必须要配合列表使用
                child: ListView(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(color: Colors.white),
                      alignment: Alignment.center,
                      child: Column(
                        children: <Widget>[
                          Image.network(
                            'http://www.devio.org/img/avatar.png',
                            width: 100,
                            height: 100,
                          ),
                          TextField(
                            // 输入文本样式
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                                hintText: '请输入',
                                helperStyle: TextStyle(fontSize: 15)),
                          ),
                          Container(
                            height: 100,
                            margin: EdgeInsets.only(top: 10),
                            decoration:
                                BoxDecoration(color: Colors.lightBlueAccent),
                            child: PageView(
                              // 类似于Android的ViewPager来实现Banner
                              children: <Widget>[
                                // 创建Item View
                                _item('page1', Colors.yellow),
                                _item('page2', Colors.orangeAccent),
                                _item('page3', Colors.greenAccent),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                onRefresh: _handleRefresh)
            : Text('页面2'),
      ),
    );
  }

  /// 下拉刷新完成后调用该方法，这里的Future 是refresh 的返回类型
  Future<Null> _handleRefresh() async {
    // 延时200ms
    await Future.delayed(Duration(milliseconds: 200));
    return null;
  }

  _item(String title, Color color) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(color: color),
      child: Text(
        title,
        style: TextStyle(fontSize: 20, color: Colors.white),
      ),
    );
  }
}
