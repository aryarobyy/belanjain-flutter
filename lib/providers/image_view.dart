import 'dart:io';

import 'package:belanjain/services/labeling_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageViewPage extends StatefulWidget {
  final String imagePath;
  const ImageViewPage({super.key, required this.imagePath});

  @override
  State<ImageViewPage> createState() => _ImageViewPageState();
}


class _ImageViewPageState extends State<ImageViewPage> {
  String? _path;
  ImagePicker? _imagePicker;

  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    final file = File(widget.imagePath);
    if (file.existsSync()) {
      file.deleteSync();
      debugPrint('File ${widget.imagePath} telah dihapus.');
    } else {
      debugPrint('File ${widget.imagePath} tidak ditemukan untuk dihapus.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Captured Image'),
      ),
      body: Center(
        child: Image.file(File(widget.imagePath)),
      ),
    );
  }
}
