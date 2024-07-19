/// author       : coffer
/// date         : 2022/10/11
/// description  :
import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class NetPage extends StatefulWidget {
  @override
  _NetPageState createState() => _NetPageState();
}

class _NetPageState extends State<NetPage> {
  String showResult = '';
  // 注意这里的Url 里的写法，需要去掉前面的http 或者 https，后面的path 要和 host 分开
  var url = Uri.https('www.devio.org','/io/flutter_app/json/test_common_model.json');

  Future<CommonModel> fetchGet() async {
    final response = await http.get(url);
    final result = convert.json.decode(response.body);
    return CommonModel.fromJson(result);
  }

  //   fetchGet2() async {
  //    var response = await http.get(url);
  //    if (response.statusCode == 200) {
  //      // var jsonResponse =
  //      // convert.jsonDecode(response.body) as Map<String, dynamic>;
  //      // var itemCount = jsonResponse['totalItems'];
  //      // print('Number of books about http: $itemCount.');
  //      print('Number of books about http: lala.');
  //    } else {
  //      print('Request failed with status: ${response.statusCode}.');
  //    }
  // }

  @override
  Widget build(BuildContext context) {
    setState(() {

    });
    return Scaffold(
      appBar: AppBar(
        title: Text('网络编程'),
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
            InkWell(
              onTap: (){
                /// 通过fetchGet().then获取Fluter的返回结果，其实Future可以理解为ES5中的Promise
                fetchGet().then((CommonModel value){
                  setState(() {
                    showResult = '请求结果：\n hideAppBar：${value.hideAppBar}\nicon：${value.icon}';
                    // showResult = '啦啦';
                  });
                });
                // fetchGet2();
              },
              child: Text(
                '请求网络',
                style: TextStyle(fontSize: 26),
              ),
            ),
            Text(showResult),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class CommonModel {
  final String icon;
  final String title;
  final String url;
  final String statusBarColor;
  final bool hideAppBar;

  CommonModel(
      {required this.icon,
        required this.title,
        required this.url,
        required this.statusBarColor,
        required this.hideAppBar});

  /// 注意这里的map 里的value 用的是dynamic 动态类型
  factory CommonModel.fromJson(Map<String, dynamic> json){
    return CommonModel(
      icon: json['icon'],
      title: json['title'],
      url: json['url'],
      statusBarColor: json['statusBarColor'],
      hideAppBar: json['hideAppBar'],
    );
  }
}
