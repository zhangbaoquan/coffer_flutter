import 'dart:async';
import 'dart:io';
import 'package:image/image.dart' as img;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

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

  final ImagePicker _picker = ImagePicker();

  Future<void> _onImageButtonPressed(
    ImageSource source, {
    required BuildContext context,
  }) async {
    if (context.mounted) {
      try {
        final XFile? pickedFile = await _picker.pickImage(
          source: source,
        );
        setState(() {
          _setImageFileListFromFile(pickedFile);
        });
      } catch (e) {
        setState(() {
          _pickImageError = e;
        });
      }
    }
  }

  Future<File> convertImage({required String inputPath, required String outputPath}) async {
    final File inputFile = File(inputPath);
    final imageBytes = await inputFile.readAsBytes();
    final img.Image image = img.decodeImage(imageBytes)!;

    // 将图片保存为PNG格式
    final List<int> pngBytes = img.encodePng(image);
    final File outputFile = File(outputPath);
    return await outputFile.writeAsBytes(pngBytes);
  }

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
    if (_mediaFileList != null) {
      /// 可以根据name ,以.作为分隔符判断最后是不是jpg文件
      debugPrint("hahah_tag image path : ${_mediaFileList![0].path}");
      handleConvert();
      return Semantics(
        label: 'image_picker_example_picked_image',
        child: Image.file(
          // File(_mediaFileList![0].path),
          File("/data/user/0/com.example.coffer_flutter/app_flutter/didi.png"),
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
      return;
    }
    if (response.file != null) {
      setState(() {
        if (response.files == null) {
          _setImageFileListFromFile(response.file);
        } else {
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
}
