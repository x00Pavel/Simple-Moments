import 'package:flutter_bloc/flutter_bloc.dart';

import 'profile_service.dart';

class ProfileState {
  bool isOpened;
  ProfileState({required this.isOpened});
}

ProfileState _reset = ProfileState(isOpened: false);

class ProfileCubit extends Cubit<ProfileState> {
  ProfileServiceImp profileServiceImp;

  ProfileCubit({required this.profileServiceImp}) : super(_reset);

  void _emitState() => emit(ProfileState(isOpened: state.isOpened));

  void resetState() => emit(_reset);

  void toggleSwitch() {
    state.isOpened = !state.isOpened;
    _emitState();
  }
}
