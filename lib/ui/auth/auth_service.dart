import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:simple_moments/api_service/service.dart';
import 'package:simple_moments/database/database.dart';
import 'package:simple_moments/dependency/navigation/global_router_exports.dart';
import 'package:simple_moments/utils/helpers.dart';
import 'package:simple_moments/utils/loader_dialog.dart';

import '../../dependency/navigation/navigator_routes.dart';
import 'auth_cubit.dart';

abstract class AuthService {
  Future<String> phoneAuth({
    required String phoneNumber,
    required String dailCode,
  });

  Future<void> googleAuth();

  Future<void> validateOtp({required String otp, required String token});

  Future<void> addDeviceToken({required String token});
}

class AuthServiceImp extends AuthService {
  ServiceHelpersImp serviceHelpersImp;
  TempDatabaseImpl tempDatabaseImpl;

  AuthServiceImp(
      {required this.serviceHelpersImp, required this.tempDatabaseImpl});

  @override
  Future<void> googleAuth() async {
    try {
      showLoaderDialog();
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
      final googleUser = await googleSignIn.signIn();

      globalPop();

      if (googleUser != null) {
        showLoaderDialog();
        final googleAuth = await googleUser.authentication;

        globalPop();
        if (googleAuth.accessToken != null) {
          var response = await serviceHelpersImp.post(
              endPointUrl: 'auth/google',
              body: {'ID_token': googleAuth.idToken});

          tempDatabaseImpl.saveUserToken(token: '2');
          globalNavigateTo(route: Routes.domain);

          response.fold((left) => globalToast('Sorry, an error occurred'),
              (right) {
            if (right.statusCode == 200) {
              globalToast(right.data['message']);

              // tempDatabaseImpl.saveUserToken(token: '2');
              // globalNavigateTo(route: Routes.domain);
            }
          });
        }
      } else {
        globalToast('An error occurred.');
      }
    } catch (_) {
      globalPop();
      globalToast('An error occurred.');
    }
  }

  @override
  Future<String> phoneAuth({
    required String phoneNumber,
    required String dailCode,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    String verificationId = '';

    await auth.verifyPhoneNumber(
      phoneNumber: '$dailCode$phoneNumber',
      timeout: const Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential credential) async {},
      verificationFailed: (FirebaseAuthException error) {
        globalToast('Error occurred, please try again.');
      },
      codeSent: (String verificationId, int? forceResendingToken) {
        buildContext.read<AuthCubit>().saveID(verificationId: verificationId);
        globalNavigateTo(route: Routes.otpScreen);
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        verificationId = verificationId;
      },
    );
    return verificationId;
  }

  @override
  Future<void> validateOtp({
    required String otp,
    required String token,
  }) async {
    showLoaderDialog();
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      await auth
          .signInWithCredential(
              PhoneAuthProvider.credential(verificationId: token, smsCode: otp))
          .then((value) {
        if (value.user != null) {
          print('value.user!.uid ${value.user!.uid}');
          globalNavigateTo(route: Routes.domain);
          globalToast('Successfully logged in');
        } else {
          globalToast('An error in verification, please try again.');
        }
      });
    } catch (e) {
      globalPop();
      globalToast('An error in verification, please try again.');
    }
  }

  @override
  Future<void> addDeviceToken({required String token}) {
    // TODO: implement addDeviceToken
    throw UnimplementedError();
  }
}
