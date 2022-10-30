/// author       : coffer
/// date         : 2022/10/11
/// description  :
import 'package:flutter/material.dart';
const CITY_NAMES = {
  '北京': ['东城区', '西城区', '朝阳区', '丰台区', '石景山区', '海淀区', '顺义区'],
  '上海': ['黄浦区', '徐汇区', '长宁区', '静安区', '普陀区', '闸北区', '虹口区'],
  '广州': ['越秀', '海珠', '荔湾', '天河', '白云', '黄埔', '南沙', '番禺'],
  '深圳': ['南山', '福田', '罗湖', '盐田', '龙岗', '宝安', '龙华'],
  '杭州': ['上城区', '下城区', '江干区', '拱墅区', '西湖区', '滨江区'],
  '苏州': ['姑苏区', '吴中区', '相城区', '高新区', '虎丘区', '工业园区', '吴江区']
};

class ListPage2 extends StatefulWidget {
  @override
  _ListPage2State createState() => _ListPage2State();
}

class _ListPage2State extends State<ListPage2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('可展开列表'),
        leading: GestureDetector(
          onTap: () {
            // 返回上个页面
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back),
        ),
      ),
      body: Center(
        child: ListView(
          children: _buildList(),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  List<Widget> _buildList() {
    List<Widget> widgets = [];
    CITY_NAMES.keys.forEach((key) {
      widgets.add(_item(key,CITY_NAMES[key]!));
    });
    return widgets;
  }

  Widget _item(String city,List<String> subCities) {
    return ExpansionTile(
      // 可展开的Item
      title: Text(
        city,
        style: const TextStyle(color: Colors.black54, fontSize: 20),
      ),
      children: subCities.map((subCity) => _buildSub(subCity)).toList(),
    );
  }

  Widget _buildSub(String subCity) {
    return FractionallySizedBox(
       // 使用 FractionallySizedBox 以及下面的widthFactor 的作用是让View 的宽度撑满
        widthFactor: 1,
        child: Container(
          height: 50,
          margin: const EdgeInsets.only(bottom: 5),
          decoration: const BoxDecoration(color: Colors.lightBlueAccent),
          child: Text(subCity),
        ));
  }
}
