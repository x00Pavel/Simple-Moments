import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:simple_moments/database/database.dart';
import 'package:simple_moments/database/user_model/user_model.dart';
import 'package:simple_moments/dependency/navigation/global_router_exports.dart';
import 'package:simple_moments/dependency/navigation/navigator_routes.dart';
import 'package:simple_moments/ui/global_components/bottom_nav_widget.dart';
import 'package:simple_moments/utils/date_time_picker.dart';

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

  void logOut() {
    final googleSignIn = Platform.isAndroid
        ? GoogleSignIn(scopes: [
            'email',
            'https://www.googleapis.com/auth/contacts.readonly',
          ])
        : GoogleSignIn(
            clientId:
                '753034776950-oaermto4vgkg26i9qs0e4ha07orujooh.apps.googleusercontent.com',
            scopes: [
                'email',
                'https://www.googleapis.com/auth/contacts.readonly',
              ]);
    globalNavigateUntil(route: Routes.getStartedScreen);
    pagePosition.value = 0;
    tempDatabaseImpl.clearUserData();
    googleSignIn.signOut();
    resetState();
  }

  Future<void> getProfile() async {
    await tempDatabaseImpl.getUserData().then((userData) {
      if (userData.isNotEmpty) {
        state.profileModel = profileModelFromJson(userData);
        state.isOpened = state.profileModel!.user.notifyMoments;
        _emitState();
      }
    });

    await profileServiceImp.getProfile().whenComplete(() {
      tempDatabaseImpl.getUserData().then((userData) {
        if (userData.isNotEmpty) {
          state.profileModel = profileModelFromJson(userData);
          state.isOpened = state.profileModel!.user.notifyMoments;
          _emitState();
        }
      });
    });
  }

  void changeTime() async {
    if (state.profileModel != null) {
      await calendarTimePicker(
              title: 'Select Notification Time',
              dateTime: state.profileModel!.user.notifyTime)
          .then((dateTime) =>
              profileServiceImp.updateNotifyTime(dateTime: dateTime));
    }
  }

  void isNotify() async {
    if (state.profileModel != null) {
      profileServiceImp.updateNotifyTime(
          notify: !state.profileModel!.user.notifyMoments);
    }
  }
}
