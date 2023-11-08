import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:simple_moments/database/moments_model/moments_model.dart';
import 'package:simple_moments/dependency/navigation/global_router_exports.dart';
import 'package:simple_moments/dependency/navigation/navigator_routes.dart';

import 'home_service.dart';

class HomeState {
  List<Moment> moments;
  bool isLoading;

  HomeState({required this.moments, required this.isLoading});
}

HomeState _reset = HomeState(moments: [], isLoading: false);

class HomeCubit extends Cubit<HomeState> {
  HomeServiceImp homeServiceImp;

  HomeCubit({required this.homeServiceImp}) : super(_reset);

  void _emitState() =>
      emit(HomeState(moments: state.moments, isLoading: state.isLoading));

  void resetState() => emit(_reset);

  void getMoments() {
    state.isLoading = true;
    _emitState();
    Future.delayed(const Duration(seconds: 5), () {
      state.isLoading = false;
      state.moments = demoMoments;
      _emitState();
    });
  }

  void captureMoment({bool isFromAllowScreen = false}) async {
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
