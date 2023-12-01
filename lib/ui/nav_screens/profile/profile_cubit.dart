import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_moments/database/database.dart';
import 'package:simple_moments/database/user_model/user_model.dart';
import 'package:simple_moments/dependency/navigation/global_router_exports.dart';
import 'package:simple_moments/dependency/navigation/navigator_routes.dart';
import 'package:simple_moments/ui/global_components/bottom_nav_widget.dart';
import 'package:simple_moments/ui/nav_screens/home/home_cubit.dart';

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

  void logOut() {
    globalNavigateUntil(route: Routes.getStartedScreen);
    pagePosition.value = 0;
    tempDatabaseImpl.clearUserData();
    resetState();
  }

  Future<void> getProfile() async {
    await tempDatabaseImpl.getUserData().then((userData) {
      if (userData.isNotEmpty) {
        state.profileModel = profileModelFromJson(userData);
        _emitState();
      }
    });

    await profileServiceImp.getProfile().whenComplete(() {
      buildContext.read<HomeCubit>().getMoments();
      tempDatabaseImpl.getUserData().then((userData) {
        if (userData.isNotEmpty) {
          state.profileModel = profileModelFromJson(userData);
          _emitState();
        }
      });
    });
  }
}
