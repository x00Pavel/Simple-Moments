import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MomentState {
  CameraController? controller;
  List<CameraDescription> cameras = [];
  bool isFrontCamera;
  Timer? _timer;
  int start;

  MomentState({
    required this.controller,
    required this.cameras,
    required this.isFrontCamera,
    required Timer? timer,
    required this.start,
  }) : _timer = timer;
}

MomentState _reset = MomentState(
  controller: null,
  cameras: [],
  isFrontCamera: true,
  timer: null,
  start: 5,
);

class MomentCubit extends Cubit<MomentState> {
  MomentCubit() : super(_reset);

  void _emitState() => emit(MomentState(
        controller: state.controller,
        cameras: state.cameras,
        isFrontCamera: state.isFrontCamera,
        timer: state._timer,
        start: state.start,
      ));

  void resetState() => emit(_reset);

  void initializeCamera() async {
    state.cameras = await availableCameras();
    state.controller = CameraController(state.cameras[1], ResolutionPreset.max);
    state.controller!.initialize().then((value) => _emitState());
  }

  void switchCamera() async {
    state.controller = CameraController(
        state.cameras[state.isFrontCamera ? 0 : 1], ResolutionPreset.max);
    state.controller!.initialize();
    state.controller!.initialize().then((value) => _emitState());
  }

  Future<void> startRecording() async {
    if (state.controller == null ||
        !state.controller!.value.isInitialized ||
        state.controller!.value.isRecordingVideo) {
      return;
    }

    try {
      await state.controller!.startVideoRecording();
      Future.delayed(const Duration(seconds: 5), () {
        stopRecording();
        _startTimer();
      });
    } on CameraException catch (_) {}
  }

  Future<void> stopRecording() async {
    if (state.controller == null ||
        !state.controller!.value.isInitialized ||
        state.controller!.value.isRecordingVideo) {
      return;
    }

    try {
      await state.controller!.stopVideoRecording();
      if (state._timer != null) {
        state._timer!.cancel();
      }
    } on CameraException catch (_) {}
  }

  void _startTimer() {
    const oneSec = Duration(seconds: 1);
    state._timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (state.start == 0) {
          timer.cancel();
        } else {
          state.start--;
        }
      },
    );
    _emitState();
  }
}
