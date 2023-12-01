import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_moments/database/database.dart';
import 'package:simple_moments/database/user_model/user_model.dart';

import 'profile_service.dart';

class ProfileState {
  bool isOpened;
  ProfileModel? profileModel;

  ProfileState({required this.isOpened, required this.profileModel});
}

ProfileState _reset = ProfileState(isOpened: false, profileModel: null);

class ProfileCubit extends Cubit<ProfileState> {
  ProfileServiceImp profileServiceImp;
  TempDatabaseImpl tempDatabaseImpl;

  ProfileCubit(
      {required this.profileServiceImp, required this.tempDatabaseImpl})
      : super(_reset);

  void _emitState() => emit(
      ProfileState(isOpened: state.isOpened, profileModel: state.profileModel));

  void resetState() => emit(_reset);

  void toggleSwitch() {
    state.isOpened = !state.isOpened;
    _emitState();
  }

  Future<void> getProfile() async {
    await tempDatabaseImpl.getUserData().then((userData) {
      if (userData.isNotEmpty) {
        state.profileModel = profileModelFromJson(userData);
        _emitState();
      }
    });

    await profileServiceImp.getProfile().whenComplete(() {
      tempDatabaseImpl.getUserData().then((userData) {
        if (userData.isNotEmpty) {
          state.profileModel = profileModelFromJson(userData);
          _emitState();
        }
      });
    });
  }
}
