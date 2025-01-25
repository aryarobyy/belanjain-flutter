import 'dart:io';

import 'package:belanjain/providers/image_view.dart';
import 'package:belanjain/services/labeling_service.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';

class KameraScreen extends StatefulWidget {
  const KameraScreen({super.key});

  @override
  State<KameraScreen> createState() => _KameraScreenState();
}

class _KameraScreenState extends State<KameraScreen> {
  List<CameraDescription> cameras = [];
  CameraController? controller;
  Future<void>? _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    requestPermissions();
    _setupCameraController();
  }

  Future<void> requestPermissions() async {
    if (!await Permission.camera.isGranted) {
      await Permission.camera.request();
    }
    if (!await Permission.storage.isGranted) {
      await Permission.storage.request();
    }

    if (!await Permission.camera.isGranted) {
      print("Izin kamera ditolak");
      return;
    }
  }


  Future<void> _setupCameraController() async {
    try {
      cameras = await availableCameras();

      if (cameras.isNotEmpty) {
        controller = CameraController(
          cameras.first,
          ResolutionPreset.high,
        );

        _initializeControllerFuture = controller!.initialize();
        await _initializeControllerFuture;

        await SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]);

        setState(() {});
      } else {
        print("Tidak ada kamera yang tersedia");
      }
    } catch (e) {
      print("Gagal mengatur kamera: $e");
    }
  }


  void takePicture() async {
    try {
      if (controller == null || !controller!.value.isInitialized) {
        print("Kamera belum siap");
        return;
      }

      String uuid = Uuid().v4();

      final XFile image = await controller!.takePicture();

      final Directory appDir = await getApplicationDocumentsDirectory();
      final String savedImagePath = '${appDir.path}/captured_image_$uuid.jpg';
      // print("Saved image path $savedImagePath");
      await File(image.path).copy(savedImagePath);

      //final path = 'assets/ml/object_labeler.tflite';
      //final modelPath = await _getModel(path);
      //final options = LocalLabelerOptions(modelPath: modelPath);
      //_imageLabeler = ImageLabeler(options: options);
      // LabelingService(savedImagePath);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ImageViewPage(imagePath: savedImagePath),
        ),
      );
      print('Gambar berhasil disimpan di: $savedImagePath');
    } catch (e) {
      print('Terjadi kesalahan saat mengambil atau menyimpan gambar: $e');
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (controller != null && controller!.value.isInitialized) {
              return SafeArea(
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: RotatedBox(
                        quarterTurns: 1,
                        child: AspectRatio(
                          aspectRatio: controller!.value.aspectRatio,
                          child: CameraPreview(controller!),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        color: Colors.white.withOpacity(0.3),
                        width: double.infinity,
                        height: 100,
                        child: Center(
                          child: IconButton(
                            onPressed: takePicture,
                            icon: const Icon(
                              Icons.camera_alt,
                              size: 40,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return const Center(
                child: Text(
                  'Kamera tidak dapat diinisialisasi',
                  style: TextStyle(fontSize: 16),
                ),
              );
            }
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Terjadi kesalahan: ${snapshot.error}',
                style: TextStyle(fontSize: 16),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }


}
