import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:follow_up_clinic_app/src/view/preview_page.dart';

class CameraPage extends StatefulWidget {
  final List<CameraDescription>? cameras;
  const CameraPage({Key? key, required this.cameras}) : super(key: key);
  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController _cameraController;
  bool _isRearCameraSelected = true;
  double _zoomLevel = 1.0;
  double _maxCamZoom = 0.0;

  Future initCamera(CameraDescription cameraDescription) async {
// create a CameraController
    _cameraController =
        CameraController(cameraDescription, ResolutionPreset.veryHigh);
// Next, initialize the controller. This returns a Future.
    try {
      await _cameraController.initialize().then((_) {
        if (!mounted) return;
        setState(() {});
      });
    } on CameraException catch (e) {
      debugPrint("camera error $e");
    }
  }

  Future takePicture() async {
    if (!_cameraController.value.isInitialized) {
      return null;
    }
    if (_cameraController.value.isTakingPicture) {
      return const CircularProgressIndicator();
    }
    try {
      await _cameraController.setFlashMode(FlashMode.off);
      await _cameraController.setFocusMode(FocusMode.locked);
      await _cameraController.setExposureMode(ExposureMode.locked);

      await _cameraController.setZoomLevel(_zoomLevel);

      XFile picture = await _cameraController.takePicture();

      Navigator.pop(context, picture);
    } on CameraException catch (e) {
      debugPrint('Error occured while taking picture: $e');
      return null;
    }
  }

  void _handleZoom(double zoomFactor) {
    setState(() {
      _zoomLevel = zoomFactor;
      _cameraController.setZoomLevel(zoomFactor);
    });
  }

  @override
  void initState() {
    super.initState();
    // initialize the rear camera
    initCamera(widget.cameras![0]);
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GestureDetector(
      onScaleUpdate: (details) async {
        double newZoom = _zoomLevel * (details.scale);
        _maxCamZoom = await _cameraController.getMaxZoomLevel();
        if (newZoom >= 1.0 && newZoom <= 2) {
          _handleZoom(newZoom);
        }
      },
      child: Container(
        color: Colors.black,
        child: SafeArea(
            child: Stack(children: [
          (_cameraController.value.isInitialized)
              ? Transform.scale(
                  scale: _zoomLevel,
                  child: CameraPreview(_cameraController),
                )
              : Container(
                  color: Colors.black,
                  child: const Center(child: CircularProgressIndicator())),
          Container(
            margin: const EdgeInsets.all(10),
            alignment: Alignment.topLeft,
            child: CircleAvatar(
              backgroundColor: Colors.black,
              child: IconButton(
                icon: const Icon(Icons.close),
                color: Colors.white,
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Row(
              children: <Widget>[
                OutlinedButton(onPressed: () {}, child: const Text('ตาซ้าย')),
                OutlinedButton(onPressed: () {}, child: const Text('ตาขวา')),
              ],
            ),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.20,
                decoration: const BoxDecoration(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(24)),
                    color: Colors.black),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                          child: IconButton(
                        padding: EdgeInsets.zero,
                        iconSize: 30,
                        icon: Icon(
                            _isRearCameraSelected
                                ? CupertinoIcons.switch_camera
                                : CupertinoIcons.switch_camera_solid,
                            color: Colors.white),
                        onPressed: () {
                          setState(() =>
                              _isRearCameraSelected = !_isRearCameraSelected);
                          initCamera(
                              widget.cameras![_isRearCameraSelected ? 0 : 1]);
                        },
                      )),
                      Expanded(
                          child: IconButton(
                        onPressed: takePicture,
                        iconSize: 50,
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        icon: const Icon(Icons.circle, color: Colors.white),
                      )),
                      const Spacer(),
                    ]),
              )),
        ])),
      ),
    ));
  }
}
