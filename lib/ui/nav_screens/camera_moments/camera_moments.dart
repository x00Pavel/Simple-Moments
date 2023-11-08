import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:simple_moments/dependency/navigation/global_router_exports.dart';
import 'package:simple_moments/utils/colors.dart';

import 'components/moments_back_button.dart';
import 'components/moments_controls.dart';
import 'components/moments_counter.dart';

class CameraMoments extends StatefulWidget {
  const CameraMoments({super.key});

  @override
  State<CameraMoments> createState() => _CameraMomentsState();
}

class _CameraMomentsState extends State<CameraMoments>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  CameraController? _controller;
  List<CameraDescription> cameras = [];
  bool isFrontCamera = true;
  bool isRecording = false;

  late Timer _timer;
  int _start = 5;

  void _startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    _stopRecording();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  void _initializeCamera() async {
    cameras = await availableCameras();

    _controller = CameraController(cameras[1], ResolutionPreset.max);
    _controller!.initialize().then((value) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  void switchCamera() async {
    _controller =
        CameraController(cameras[isFrontCamera ? 0 : 1], ResolutionPreset.max);
    _controller!.initialize().then((value) {
      if (!mounted) {
        return;
      }
      setState(() => isFrontCamera = !isFrontCamera);
    });
  }

  Future<void> startRecording() async {
    if (_controller == null ||
        !_controller!.value.isInitialized ||
        _controller!.value.isRecordingVideo) {
      return;
    }

    try {
      await _controller!.startVideoRecording();
      _controller!.enableAudio;
      setState(() => isRecording = true);
      _startTimer();
      Future.delayed(const Duration(seconds: 5), () => _stopRecording());
    } on CameraException catch (_) {}
  }

  Future<void> _stopRecording() async {
    try {
       _controller!.stopVideoRecording();
       _controller!.dispose();
      setState(() => isRecording = false);
    } on CameraException catch (_) {}
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController? cameraController = _controller;

    // App state changed before we got the chance to initialize.
    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      _initializeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return _controller == null || !_controller!.value.isInitialized
        ? Container(
            color: kPrimaryDark,
            child: const Center(
              child: CupertinoActivityIndicator(color: kPrimaryDark),
            ),
          )
        : Scaffold(
            body: Stack(
              fit: StackFit.expand,
              children: [
                CameraPreview(_controller!),
                 MomentsBackButton(stopRecording: () => _stopRecording(),),
                if (isRecording) MomentsCounter(start: _start),
                MomentsControls(
                  startRecording: () => startRecording(),
                  switchCamera: () => switchCamera(),
                )
              ],
            ),
          );
  }
}
