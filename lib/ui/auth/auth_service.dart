import 'dart:async';
import 'package:simple_moments/api_service/service.dart';
import 'package:simple_moments/database/database.dart';
import 'package:simple_moments/dependency/navigation/global_router_exports.dart';
import 'package:simple_moments/utils/helpers.dart';

import '../../dependency/navigation/navigator_routes.dart';

abstract class AuthService {
  Future<void> authenticate({
    required String phoneNumber,
    required String dailCode,
  });

  Future<void> resendOtp({
    required String phoneNumber,
    required String dailCode,
  });


  Future<void> validateOtp({required String otp, required String token});

  Future<void> addDeviceToken({required String token});
}

class AuthServiceImp extends AuthService {
  ServiceHelpersImp serviceHelpersImp;
  TempDatabaseImpl tempDatabaseImpl;

  AuthServiceImp(
      {required this.serviceHelpersImp, required this.tempDatabaseImpl});

  @override
  Future<void> authenticate({
    required String phoneNumber,
    required String dailCode,
  }) async {


    globalNavigateTo(route: Routes.otpScreen);

    // showLoaderDialog();
    //
    // var body = {
    //   'phone': phoneNumber[0] == '0' ? phoneNumber : '0$phoneNumber',
    //   'country_code': dailCode
    // };
    //
    // var response = await serviceHelpersImp.post(
    //     endPointUrl: '/auth/customer/send/otp', body: body);
    //
    // globalPop();
    // response.fold((left) => globalToast('Sorry, an error occurred'), (right) {
    //   if (right.statusCode == 200) {
    //     globalToast(right.data['message']);
    //     // globalNavigateUntil(route: Routes.login);
    //   }
    // });
  }

  @override
  Future<void> validateOtp({
    required String otp,
    required String token,
  }) async {
    // showLoaderDialog();
    // var body = {'token': token, 'pin': otp};
    //
    // var response = await serviceHelpersImp.post(
    //     endPointUrl: '/auth/customer/verify/otp', body: body);
    //
    // globalPop();
    // response.fold((left) => globalToast('Sorry, an error occurred'),
    //     (right) async {
    //   if (right.statusCode == 200) {
    //     globalToast(right.data['message']);
    //     tempDatabaseImpl.saveUserToken(
    //         token: right.data['data']['accessToken']);
    //   }
    // });

    // globalNavigateUntil(route: Routes.finishRegistration);
    // globalNavigateUntil(route: Routes.createPasswordScreen);
  }

  @override
  Future<void> resendOtp({
    required String phoneNumber,
    required String dailCode,
  }) async {
    var body = {
      'phone': phoneNumber[0] == '0' ? phoneNumber : '0$phoneNumber',
      'country_code': dailCode
    };

    var response = await serviceHelpersImp.post(
        endPointUrl: '/auth/customer/send/otp', body: body);

    globalPop();
    response.fold((left) => globalToast('Sorry, an error occurred'), (right) {
      if (right.statusCode == 200) {
        globalToast(right.data['message']);
        // globalNavigateUntil(route: Routes.login);
      }
    });
  }

  @override
  Future<void> addDeviceToken({required String token}) {
    // TODO: implement addDeviceToken
    throw UnimplementedError();
  }

}
