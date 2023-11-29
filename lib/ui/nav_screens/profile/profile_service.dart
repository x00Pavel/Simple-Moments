import 'dart:async';
import 'dart:convert';

import 'package:simple_moments/api_service/service.dart';
import 'package:simple_moments/database/database.dart';

abstract class ProfileService {
  Future<void> getProfile();
}

class ProfileServiceImp extends ProfileService {
  ServiceHelpersImp serviceHelpersImp;
  TempDatabaseImpl tempDatabaseImpl;

  ProfileServiceImp(
      {required this.serviceHelpersImp, required this.tempDatabaseImpl});

  @override
  Future<void> getProfile() async {
    var response =
        await serviceHelpersImp.get(endPointUrl: '/userinfo/${tempDatabaseImpl.getUserToken()}}');
    response.fold((left) => null, (right) {
      if (right.statusCode == 200) {
        tempDatabaseImpl.saveUserData(userData: jsonEncode(right.data['data']));
      }
    });
  }
}
