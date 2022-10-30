/// author       : coffer
/// date         : 2022/10/11
/// description  :
import 'package:flutter/material.dart';

class ListPage4 extends StatefulWidget {
  @override
  _ListPage4State createState() => _ListPage4State();
}

class _ListPage4State extends State<ListPage4> {
  List<String> city_name = [ '北京', '上海', '广州', '深圳', '杭州', '苏州', '成都', '武汉', '郑州', '洛阳', '厦门', '青岛', '拉萨' ];

  ScrollController _scrollController = ScrollController();
  @override
  void initState(){
    _scrollController.addListener(() {
      // 下面的意思是滑动到最底部的时候触发
      if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent){
        _loadData();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  _loadData() async{
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      // 下面是 拷贝city_name 数据到新的list 中
      List<String> list = List<String>.from(city_name);
      list.addAll(city_name);
      city_name = list;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('下拉刷新，上拉更多'),
        leading: GestureDetector(
          onTap: () {
            // 返回上个页面
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back),
        ),
      ),
      body: Center(
        child: RefreshIndicator(
          onRefresh: _handleRefresh,
          child: ListView(
            controller: _scrollController,
            children: _buildList(),
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  // 这里的Null 表示返回类型为Null
  Future<Null> _handleRefresh() async{
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      // 下拉时，将数据翻转
      city_name = city_name.reversed.toList();
    });
  }

  List<Widget> _buildList() {
    return city_name.map((city) => _item(city)).toList();
  }

  Widget _item(String city) {
    return Container(
      height: 80,
      margin: const EdgeInsets.only(bottom: 5),
      alignment: Alignment.center,
      decoration: const BoxDecoration(color: Colors.teal),
      child: Text(
        city,
        style: const TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }
}
