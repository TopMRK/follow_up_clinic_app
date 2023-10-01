import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

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
  double? _screenwidth;
  double? _screenheight;
  bool _lefteye = true;

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
      if (_cameraController.value.flashMode == true) {
        await _cameraController.setFlashMode(FlashMode.off);
      }
      await _cameraController.setFocusMode(FocusMode.locked);
      await _cameraController.setExposureMode(ExposureMode.locked);

      await _cameraController.setZoomLevel(_zoomLevel);

      XFile picture = await _cameraController.takePicture();

      dynamic value = {'picture': picture, 'left_eye': _lefteye};

      Navigator.pop(context, value);
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
    _screenwidth = MediaQuery.of(context).size.width;
    _screenheight = MediaQuery.of(context).size.height;
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
                  child: SizedBox(
                    width: _screenwidth,
                    height: _screenheight,
                    child: AspectRatio(
                      aspectRatio: _cameraController.value.aspectRatio,
                      child: CameraPreview(_cameraController),
                    ),
                  ))
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
          Container(
            margin: const EdgeInsets.all(20),
            alignment: Alignment.topCenter,
            child: Text(
              (_lefteye == true)
                  ? 'กรุณาวางตาซ้ายให้ตรงกับกรอบรูปภาพ'
                  : 'กรุณาวางตาขวาให้ตรงกับกรอบรูปภาพ',
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Image.asset((_lefteye == true)
                ? 'assets/images/Left.png'
                : 'assets/images/Right.png'),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.20,
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(24)),
                    color: Colors.black.withOpacity(0.7)),
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
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            const SizedBox(
                              height: 30,
                            ),
                            TextButton(
                                style: TextButton.styleFrom(
                                  foregroundColor:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _lefteye = true;
                                  });
                                },
                                child: const Text('ตาซ้าย')),
                            TextButton(
                                style: TextButton.styleFrom(
                                  foregroundColor:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _lefteye = false;
                                  });
                                },
                                child: const Text('ตาขวา')),
                          ],
                        ),
                      ),
                    ]),
              )),
        ])),
      ),
    ));
  }
}
