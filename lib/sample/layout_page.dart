/// author       : coffer
/// date         : 2022/10/11
/// description  :
import 'package:flutter/material.dart';
import 'package:flutter_color_plugin/flutter_color_plugin.dart';

void main() {
  runApp(FlutterLayoutPage());
}

class FlutterLayoutPage extends StatefulWidget {
  @override
  _StateFullGroupState createState() => _StateFullGroupState();
}

class _StateFullGroupState extends State<FlutterLayoutPage> {
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
                          Row(
                            children: [
                              ClipOval(
                                // ClipOval 是将里面的布局裁剪成圆形的组件
                                child: SizedBox(
                                  width: 100,
                                  height: 100,
                                  child: Image.network(
                                    'http://www.devio.org/img/avatar.png',
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(10),
                                child: ClipRRect(
                                  // 设置圆角
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  child: Opacity(
                                    opacity: 0.6, // 60% 的透明度
                                    child: Image.network(
                                      'http://www.devio.org/img/avatar.png',
                                      height: 100,
                                      width: 100,
                                    ),
                                  ),
                                ),
                              ),
                            ],
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
                            margin: EdgeInsets.all(10),
                            child: PhysicalModel(
                              color: Colors.transparent,
                              clipBehavior: Clip.antiAlias, // 设置抗锯齿
                              borderRadius: BorderRadius.circular(10),
                              child: PageView(
                                // 类似于Android的ViewPager来实现Banner
                                children: <Widget>[
                                  // 创建Item View
                                  _item('page1', Colors.yellow),
                                  _item('page2', Colors.orangeAccent),
                                  _item('page3', Colors.greenAccent),
                                ],
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              FractionallySizedBox(
                                widthFactor: 1, // 让宽度撑满
                                child: Container(
                                  decoration:
                                      BoxDecoration(color: Colors.greenAccent),
                                  child: Text('宽墩撑满'),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Stack(
                      children: [
                        Image.network(
                          'http://www.devio.org/img/avatar.png',
                          height: 100,
                          width: 100,
                        ),
                        Positioned(
                          left: 0,
                          bottom: 0, // 设置这张图位于前面这张图的左下角
                          child: Image.network(
                            'http://www.devio.org/img/avatar.png',
                            height: 36,
                            width: 36,
                          ),
                        )
                      ],
                    ),
                    Wrap(
                      // 可以实现从左到右进行排列，会自动换行
                      spacing: 8,// 水平间距
                      runSpacing: 6,// 垂直间距
                      children: [
                        _chip('Flutter'),
                        _chip('进阶'),
                        _chip('实战'),
                        _chip('Coffer'),
                        _chip('APP'),
                      ],
                    )
                  ],
                ),
                onRefresh: _handleRefresh)
            : Column(
          children: [
            Text('页面2'),
            Expanded(child: Container(
              decoration: BoxDecoration(
                  color: Colors.orange.shade50
              ),
              child: Text('拉伸填满Y轴高度'),
            ))
          ],
        ),
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

_chip(String label) {
  return Chip(
    label: Text(label),
    avatar: CircleAvatar(
      backgroundColor: Colors.blue.shade900,
      child: Text(
        label.substring(0,1),
        style: TextStyle(fontSize: 10),
      ),
    ),
  );
}
