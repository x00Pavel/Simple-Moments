import 'package:flutter_bloc/flutter_bloc.dart';

import 'profile_service.dart';

class ProfileState {
  ProfileState();
}

ProfileState _reset = ProfileState();

class ProfileCubit extends Cubit<ProfileState> {
  ProfileServiceImp homeServiceImp;

  ProfileCubit({required this.homeServiceImp}) : super(_reset);

  void _emitState() => emit(ProfileState());

  void resetState() => emit(_reset);

  void showSalesPopUp() {

  }
}
