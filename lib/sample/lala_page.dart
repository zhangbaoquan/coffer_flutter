/// author       : coffer
/// date         : 2022/10/11
/// description  :
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter_swiper/flutter_swiper.dart';

class LalaPage extends StatefulWidget {
  @override
  _LalaPageState createState() => _LalaPageState();
}

class _LalaPageState extends State<LalaPage> {
  List _imageUrls = ['https://dimg04.c-ctrip.com/images/700c10000000pdili7D8B_780_235_57.jpg'
  ,'https://dimg04.c-ctrip.com/images/700c10000000pdili7D8B_780_235_57.jpg',
    'https://dimg04.c-ctrip.com/images/700c10000000pdili7D8B_780_235_57.jpg'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('嘿嘿'),
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
            Container(
              height: 160,
              child: Image.network(
                _imageUrls[0],
                fit: BoxFit.fill,
              ),
            ),
            ClipOval(
              child: SizedBox(
                width: 100,
                height: 100,
                child: Image.network(
                  'http://www.devio.org/img/avatar.png',
                ),
              ),
            ),
            CachedNetworkImage(
              placeholder: (context, url) =>
              const CircularProgressIndicator(),
              imageUrl: 'https://via.placeholder.com/200x150',
            ),
            Stack(
              children: [
                Center(
                  child: FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: 'http://www.devio.org/img/avatar.png',
                    width: 100,
                    height: 100,
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 30),
              child: Column(
                children: [
                  Text(
                    '我是iPad ，从此我就是你的调试机，忘了Android 机吧',
                    style: TextStyle(fontSize: 36),
                  ),
                ],
              ),
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
