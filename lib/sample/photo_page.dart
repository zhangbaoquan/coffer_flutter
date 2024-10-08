import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;
import 'dart:math' as math;
import 'dart:ui';
import 'package:image/image.dart' as img;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:intl/intl.dart';


/// author       : coffer
/// date         : 2024/7/20
/// description  :
class PhotoPage extends StatefulWidget {
  const PhotoPage({super.key});

  @override
  State<PhotoPage> createState() => _PhotoPageState();
}

class _PhotoPageState extends State<PhotoPage> {
  List<XFile>? _mediaFileList;

  void _setImageFileListFromFile(XFile? value) {
    _mediaFileList = value == null ? null : <XFile>[value];
  }

  dynamic _pickImageError;
  String? _retrieveDataError;
  String imgPath = '';

  final ImagePicker _picker = ImagePicker();

  Future<void> _onImageButtonPressed(
    ImageSource source, {
    required BuildContext context,
  }) async {
    if (context.mounted) {
      try {
        final XFile? pickedFile = await _picker.pickImage(
          source: source,
          maxWidth: 1920,
          maxHeight: 1080
        );
        // debugPrint("hahah_tag _onImageButtonPressed image size : ${pickedFile?.path}");
        imgPath = await imageAddWaterMark(pickedFile!.path,"lala");
        // imgPath = await convertImage(inputPath: pickedFile!.path);
        setState(() {
          debugPrint("hahah_tag _onImageButtonPressed image path : ${pickedFile?.path}");
        });
      } catch (e) {
        setState(() {
          _pickImageError = e;
        });
      }
    }
  }

  // Future<String> convertImage({required String inputPath}) async {
  //   final File inputFile = File(inputPath);
  //   debugPrint("hahah_tag 原始大小 : ${inputFile.lengthSync()}");
  //   final imageBytes = await inputFile.readAsBytes();
  //   final img.Image image = img.decodeImage(imageBytes)!;
  //
  // String outPath = "";
  // Directory ll = await getApplicationDocumentsDirectory();
  // outPath = ll.path;
  // debugPrint("hahah_tag 外部目录 : ${ll.path}");
  //
  //   // 将图片保存为PNG格式
  //   final List<int> pngBytes = img.encodePng(image);
  //   final File outputFile = File("$outPath/didi.png");
  //   await outputFile.writeAsBytes(pngBytes);
  //   debugPrint("hahah_tag 转成png大小 : ${outputFile.lengthSync()}");
  //   return outputFile.path;
  // }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _previewImages() {
    final Text? retrieveError = _getRetrieveErrorWidget();
    if (retrieveError != null) {
      return retrieveError;
    }
    if (imgPath != null) {
      /// 可以根据name ,以.作为分隔符判断最后是不是jpg文件
      debugPrint("hahah_tag build image path : ${imgPath}");
      return Semantics(
        label: 'image_picker_example_picked_image',
        child: Image.file(
          File(imgPath),
          errorBuilder: (BuildContext context, Object error,
              StackTrace? stackTrace) {
            return const Center(
                child:
                Text('This image type is not supported'));
          },
        ),
      );
    } else if (_pickImageError != null) {
      return Text(
        'Pick image error: $_pickImageError',
        textAlign: TextAlign.center,
      );
    } else {
      return const Text(
        'You have not yet picked an image.',
        textAlign: TextAlign.center,
      );
    }
  }

  void handleConvert() async{
    ///获取本地磁盘路径
    /*
     * 在Android平台中获取的是/data/user/0/com.example.coffer_flutter/app_flutter
     * 此方法在在iOS平台获取的是Documents路径
     */
    String outPath = "";
    Directory ll = await getApplicationDocumentsDirectory();
    outPath = ll.path;
    debugPrint("hahah_tag 外部目录 : ${ll.path}");
    // File outFile = await convertImage(inputPath: _mediaFileList![0].path,outputPath: "$outPath/didi.png");
    // debugPrint("hahah_tag 转换后的 path : ${outFile.path}");
  }

  Widget _handlePreview() {
    return _previewImages();
  }

  Future<void> retrieveLostData() async {
    final LostDataResponse response = await _picker.retrieveLostData();
    if (response.isEmpty) {
      debugPrint("hahah_tag retrieveLostData response 空了");
      return;
    }
    if (response.file != null) {
      setState(() {
        if (response.files == null) {
          debugPrint("hahah_tag retrieveLostData 空了");
          _setImageFileListFromFile(response.file);
        } else {
          debugPrint("hahah_tag retrieveLostData image path : ${response.files![0].path}");
          _mediaFileList = response.files;
        }
      });
    } else {
      _retrieveDataError = response.exception!.code;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("图片选择与加工"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: FloatingActionButton(
              backgroundColor: Colors.red,
              onPressed: () {
                _onImageButtonPressed(ImageSource.camera, context: context);
              },
              heroTag: 'video1',
              tooltip: 'Take a Video',
              child: const Icon(Icons.camera_alt),
            ),
          ),
          Center(
            child: !kIsWeb && defaultTargetPlatform == TargetPlatform.android
                ? FutureBuilder<void>(
                    future: retrieveLostData(),
                    builder:
                        (BuildContext context, AsyncSnapshot<void> snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                        case ConnectionState.waiting:
                          return const Text(
                            'You have not yet picked an image.',
                            textAlign: TextAlign.center,
                          );
                        case ConnectionState.done:
                          return _handlePreview();
                        case ConnectionState.active:
                          if (snapshot.hasError) {
                            return Text(
                              'Pick image/video error: ${snapshot.error}}',
                              textAlign: TextAlign.center,
                            );
                          } else {
                            return const Text(
                              'You have not yet picked an image.',
                              textAlign: TextAlign.center,
                            );
                          }
                      }
                    },
                  )
                : _handlePreview(),
          ),
        ],
      ),
    );
  }

  Text? _getRetrieveErrorWidget() {
    if (_retrieveDataError != null) {
      final Text result = Text(_retrieveDataError!);
      _retrieveDataError = null;
      return result;
    }
    return null;
  }

  /// 拿到图片的字节数组
  Future<ui.Image> loadImageByFile(String path) async {
    var list = await File(path).readAsBytes();
    return loadImageByUint8List(list);
  }

  /// 通过[Uint8List]获取图片
  Future<ui.Image> loadImageByUint8List(Uint8List list) async {
    ui.Codec codec = await ui.instantiateImageCodec(list);
    ui.FrameInfo frame = await codec.getNextFrame();
    return frame.image;
  }

  /// 图片加文字
  Future<String> imageAddWaterMark(String imagePath0, String textStr) async {
    File file0 = File(imagePath0);
    debugPrint("hahah_tag 原始文件的file.lengthSync : ${file0.lengthSync()}");
    int width, height;
    //拿到Canvas
    ui.PictureRecorder recorder = ui.PictureRecorder();
    Canvas canvas = Canvas(recorder);
    //拿到Image对象
    ui.Image image = await loadImageByFile(imagePath0);
    width = image.width;
    height = image.height;
    debugPrint("hahah_tag 原始文件的width : $width , height : $height");
    canvas.drawImage(image, Offset(0, 0), Paint());
    // 绘制文字
    ui.ParagraphBuilder pb = ui.ParagraphBuilder(ui.ParagraphStyle(
        textAlign: TextAlign.left,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
        fontSize: 28.0));
    pb.pushStyle(ui.TextStyle(color: Colors.yellowAccent));
    pb.addText(formatDateTime(DateTime.now()));
    // 设置文本的宽度约束
    ParagraphConstraints pc = ui.ParagraphConstraints(width: 1000);
    ui.Paragraph paragraph = pb.build()..layout(pc);
    canvas.drawParagraph(
        // paragraph, Offset(120, image.height.toDouble() + 20));
        paragraph, Offset(30, 30));

    ui.Picture picture = recorder.endRecording();
    final img = await picture.toImage(width.toInt(), height.toInt());

    final pngBytes = await img.toByteData(format: ui.ImageByteFormat.png);

    final Directory _directory = await getTemporaryDirectory();
    debugPrint("hahah_tag _directory path : ${_directory.path}");
    String dir = '${_directory.path}/image/';
    final Directory _imageDirectory = Directory(dir);
    bool existsSync = _imageDirectory.existsSync();
    if(existsSync){
      debugPrint("hahah_tag 当前目录存在");
    } else {
      await _imageDirectory.create(recursive: true);
    }
    String _targetPath = _imageDirectory.path;
    debugPrint("hahah_tag _targetPath : $_targetPath");

    File file = File('${_targetPath}watermark${DateTime.now().millisecondsSinceEpoch}.png');
    debugPrint("hahah_tag file.path : ${file.path}");
    debugPrint("hahah_tag 加水印后的file.lengthSync 0 : ${pngBytes!.buffer.asUint8List().length}");
    file.writeAsBytesSync(pngBytes!.buffer.asUint8List());
    debugPrint("hahah_tag 加水印后的file.lengthSync : ${file.lengthSync()}");

    String outPath = "";
    Directory ll = await getApplicationDocumentsDirectory();
    outPath = ll.path;
    debugPrint("hahah_tag 外部目录 : ${ll.path}");

    // 图片压缩
    var result = await FlutterImageCompress.compressAndGetFile(
      file.path,
      "$outPath/didi.png",
      quality: 90,
      format: CompressFormat.png
    );
    debugPrint("hahah_tag 压缩后的file.path : ${result!.path}");
    File file2 = File(result!.path);
    debugPrint("hahah_tag 压缩后的file.lengthSync : ${file2.lengthSync()}");
    return file2.path;

    // var result = await FlutterImageCompress.compressWithList(
    //     pngBytes!.buffer.asUint8List(),
    //     quality: 80,
    //     format: CompressFormat.png
    // );
    // File file2 = File("$outPath/didi.png");
    // file2.writeAsBytesSync(result);
    // debugPrint("hahah_tag 压缩后的file.lengthSync : ${file2.lengthSync()}");
    // return file2.path;
  }

  String formatDateTime(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
  }
}
