import 'package:flutter/material.dart';

/// author       : coffer
/// date         : 2024/7/19
/// description  :
class UploadPage extends StatelessWidget {
  const UploadPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: CustomScrollView(
        slivers: [
          const SliverAppBar(
            pinned: true,
            expandedHeight: 250,
            flexibleSpace: FlexibleSpaceBar(
              title: Text("咖啡老师"),
              background: Image(
                  image: AssetImage('images/miku2.jpg')
              ),
            ),
          ),
          SliverPadding(padding: const EdgeInsets.all(8),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 4
            ),
            delegate: SliverChildBuilderDelegate((BuildContext context,int index){
              return Container(
                alignment: Alignment.center,
                color: Colors.cyan[100 * (index % 9)],
                child: Text('grid item $index'),
              );
            },childCount: 50),
          ),)
        ],
      ),
    );
  }
  
}