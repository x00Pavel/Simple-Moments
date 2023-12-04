import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_moments/api_service/service.dart';
import 'package:simple_moments/database/database.dart';
import 'package:simple_moments/dependency/navigation/global_router_exports.dart';
import 'package:simple_moments/dependency/navigation/navigator_routes.dart';
import 'package:simple_moments/utils/loader_dialog.dart';

import 'profile_cubit.dart';

abstract class ProfileService {
  Future<void> getProfile();

  Future<void> updateNotifyTime({DateTime? dateTime, bool? notify});
}

class ProfileServiceImp extends ProfileService {
  ServiceHelpersImp serviceHelpersImp;
  TempDatabaseImpl tempDatabaseImpl;

  ProfileServiceImp(
      {required this.serviceHelpersImp, required this.tempDatabaseImpl});

  @override
  Future<void> getProfile() async {
    var response = await serviceHelpersImp.get(
        endPointUrl: 'user/info/${await tempDatabaseImpl.getUserToken()}');

    response.fold((left) => null, (right) async {
      if (right.statusCode == 200) {
        tempDatabaseImpl.saveUserData(userData: jsonEncode(right.data));
      }
    });
  }

  @override
  Future<void> updateNotifyTime({DateTime? dateTime, bool? notify}) async {
    if (notify == null) showLoaderDialog();

    var response =
        await serviceHelpersImp.post(endPointUrl: 'user/set/notify', body: {
      'notify_time': dateTime.toString(),
      'notify_moments': notify ,
      'user_id': await tempDatabaseImpl.getUserToken()
    });

    if (notify == null) globalPop();

    response.fold((left) => debugPrint(left.message), (right) async {
      if (right.statusCode == 200) {
        buildContext.read<ProfileCubit>().getProfile();
      }
    });
  }
}
