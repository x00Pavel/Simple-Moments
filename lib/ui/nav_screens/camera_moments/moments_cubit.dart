import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_moments/dependency/navigation/navigator_routes.dart';
import 'package:simple_moments/ui/nav_screens/home/home_service.dart';

import 'moments_video_player.dart';

class MomentState {
  String filePath;

  MomentState({required this.filePath});
}

MomentState _reset = MomentState(
  filePath: '',
);

class MomentCubit extends Cubit<MomentState> {
  HomeServiceImp homeServiceImp;

  MomentCubit({required this.homeServiceImp}) : super(_reset);

  void _emitState() => emit(MomentState(
        filePath: state.filePath,
      ));

  void resetState() => emit(_reset);

  void saveVideo({required String filePath}) {
    state.filePath = filePath;
    _emitState();
    showModalBottomSheet(
      context: buildContext,
      isScrollControlled: true,
      backgroundColor: Colors.black26,
      barrierColor: Colors.black54,
      builder: (context) => const MomentsVideoPlayer(),
    );
  }

  void uploadMoment() {
    homeServiceImp.uploadMoment(imagePath: state.filePath);
  }

}
