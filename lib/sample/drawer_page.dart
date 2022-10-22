/// author       : coffer
/// date         : 2022/10/22
/// description  : 侧拉显示

import 'package:flutter/material.dart';


class DrawerPage extends StatefulWidget {
  final appTitle = 'Drawer Demo';

  @override
  _DrawerPageState createState() => _DrawerPageState(title: appTitle);
}

class _DrawerPageState extends State<StatefulWidget> {
  final String title;

  _DrawerPageState({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(title),
        actions: [
          IconButton(onPressed: (){
            Navigator.pop(context);
          }, icon: const Icon(Icons.share))
        ],
      ),
      body: const Center(child: Text('My Page!')),
      drawer: Drawer( // 侧拉
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Item 1'),
              onTap: () {
                // 收起侧拉
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Item 2'),
              onTap: () {
                // 收起侧拉
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
