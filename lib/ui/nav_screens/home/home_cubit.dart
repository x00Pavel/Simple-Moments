import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:simple_moments/database/moments_model/moments_model.dart';
import 'package:simple_moments/dependency/navigation/global_router_exports.dart';
import 'package:simple_moments/dependency/navigation/navigator_routes.dart';

import 'home_service.dart';

class HomeState {
  List<Moment> moments;
  List<Video> videoList = [];
  int prevVideo = 0;
  bool isLoading;

  HomeState(
      {required this.moments,
      required this.isLoading,
      required this.videoList,
      required this.prevVideo});
}

List<Video> videos = [
  Video(
      video: 'https://firebasestorage.googleapis.com/v0/b/'
          'videostreaming-test.appspot.com/o/vid%2FSnaptik_'
          '6745671851688692998_tiktok.mp4?alt=media&token='
          'e6c76be2-9d8e-4be6-aedc-89ddd4985871',
      tempImg: 'https://www.rd.com/wp-content/uploads'
          '/2017/09/01-shutterstock_476340928'
          '-Irina-Bg-1024x683.jpg'),
  Video(
      video: 'https://firebasestorage.googleapis'
          '.com/v0/b/videostreaming-test.appspot.'
          'com/o/vid%2FSnaptik_6842407707551599878_'
          'carlos-barrios%20(1).mp4?alt=media&token='
          '965f5080-2771-4477-bd9d-defc7b581c5d',
      tempImg: 'https://i.pinimg.com/originals/'
          '5e/eb/8d/5eeb8d615bea040425f9937699392751.jpg'),
  Video(
      video:
          'https://firebasestorage.googleapis.com/v0/b/videostreaming-test.appspo'
          't.com/o/vid%2FSnaptik_685676984238562'
          '0229_alex.mp4?alt=media&token=b70d853b-760a-45ee-b5d3-44cef7e4db7f',
      tempImg: 'https://www.rd.com/wp-content/'
          'uploads/2017/09/01-shutterstock_476340928-Irina-Bg-1024x683.jpg'),
];

HomeState _reset =
    HomeState(moments: [], videoList: [], isLoading: false, prevVideo: 0);

class HomeCubit extends Cubit<HomeState> {
  HomeServiceImp homeServiceImp;

  HomeCubit({required this.homeServiceImp}) : super(_reset);

  void _emitState() => emit(HomeState(
      moments: state.moments,
      videoList: state.videoList,
      isLoading: state.isLoading,
      prevVideo: state.prevVideo));

  void resetState() => emit(_reset);

  Future<void> getMoments() async {
    state.isLoading = true;
    _emitState();
    await homeServiceImp.getMoments().then((value) {
      if (value.isNotEmpty) {
        state.moments = value;
        _emitState();
      }
    });
    state.isLoading = false;
    _emitState();
  }

  getVideos({required Moment moment}) async {
    state.videoList = moment.videos;
    try {
      _loadVideo(0);
      _loadVideo(1);
    } catch (_) {}
    state.isLoading = false;
    _emitState();
  }

  void _loadVideo(int index) async {
    if (state.videoList.length > index) {
      await state.videoList[index].loadController();
      state.videoList[index].controller?.play();
      _emitState();
    }
  }

  changeVideo(index) async {
    if (state.videoList[index].controller == null) {
      await state.videoList[index].loadController();
    }
    state.videoList[index].controller!.play();
    if (state.videoList[state.prevVideo].controller != null) {
      state.videoList[state.prevVideo].controller!.pause();
    }
    state.prevVideo = index;
    _emitState();
  }

  void captureMoment({bool isFromAllowScreen = false}) async {
    if (Platform.isIOS) {
      globalNavigateTo(route: Routes.cameraMoments);
      return;
    }
    var statusCamera = await Permission.camera.status;
    var statusMic = await Permission.microphone.status;

    if (statusCamera.isGranted || statusMic.isGranted) {
      globalNavigateTo(route: Routes.cameraMoments);
      return;
    }

    if (statusCamera.isPermanentlyDenied || statusMic.isGranted) {
      isFromAllowScreen
          ? globalReplaceWith(route: Routes.cameraDenied)
          : globalNavigateTo(route: Routes.cameraDenied);
      return;
    }
    if (statusCamera.isLimited ||
        statusCamera.isDenied ||
        statusMic.isLimited ||
        statusMic.isDenied) {
      globalNavigateTo(route: Routes.allowCamera);
      return;
    }
  }

  void allowCameraPermission() async =>
      await Permission.camera.request().then((value) => _allowMicPermission());

  void _allowMicPermission() async {
    await Permission.microphone
        .request()
        .then((value) => captureMoment(isFromAllowScreen: true));
  }

  Future<void> enableCameraFromSettings() async {
    var statusCamera = await Permission.camera.status;
    var statusMic = await Permission.microphone.status;
    if (statusCamera.isPermanentlyDenied ||
        statusCamera.isDenied ||
        statusMic.isPermanentlyDenied ||
        statusMic.isDenied) {
      openAppSettings();
    }
  }
}
