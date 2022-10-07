import 'dart:io';
import 'package:camera/camera.dart';
import 'package:cv_test_project/themes/button_theme.dart';
import 'package:flutter/material.dart';
import '../core/logger/logger.dart';
import '../main.dart';
import 'layout_template.dart';
import 'video_page.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController controller;
  bool isRecording = false;

  @override
  void initState() {
    super.initState();
    controller = CameraController(cameras.last, ResolutionPreset.max);
    _initCamera();
  }

  void _initCamera() {
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            logDebug('User denied camera access.');
            break;
          default:
            logDebug('Handle other errors.');
            break;
        }
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      child: controller.value.isInitialized
          ? _cameraViewBuilder()
          : const Text('No camera'),
    );
  }

  Widget _cameraViewBuilder() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // CameraPreview(controller),
          // TextButton(
          //   onPressed: () {
          //     navigateTo(initialRoute);
          //   },
          //   child: const Text('Go back'),
          // ),
          JTButton.rounded(
            onPressed: () async {
              if (isRecording) {
                final video = await controller.stopVideoRecording();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => VideoPage(file: File(video.path)),
                  ),
                );
                setState(() {
                  isRecording = false;
                });
              } else {
                await controller.prepareForVideoRecording();
                await controller.startVideoRecording();
                setState(() {
                  isRecording = true;
                });
              }
            },
            child: Icon(
              isRecording ? Icons.stop : Icons.play_arrow,
              size: 24,
              color: Colors.white,
            ),
          ),
          JTButton.rounded(
            onPressed: () {
              setState(() {
                if (controller.description.lensDirection ==
                    CameraLensDirection.front) {
                  controller =
                      CameraController(cameras[0], ResolutionPreset.max);
                } else {
                  controller =
                      CameraController(cameras[1], ResolutionPreset.max);
                }
                _initCamera();
              });
            },
            child: Icon(
              Icons.cameraswitch_outlined,
              size: 24,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
