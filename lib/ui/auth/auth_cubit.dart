import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_service.dart';

class AuthState {
  bool isLoading;
  String phoneNumber;
  String dailCode;
  String verificationId, password, confirmPassword;

  AuthState({
    required this.isLoading,
    required this.phoneNumber,
    required this.dailCode,
    required this.password,
    required this.verificationId,
    required this.confirmPassword,
  });
}

class AuthCubit extends Cubit<AuthState> {
  AuthServiceImp authServiceImp;

  AuthCubit({required this.authServiceImp})
      : super(AuthState(
          isLoading: false,
          dailCode: '',
          phoneNumber: '',
          verificationId: '',
          password: '',
          confirmPassword: '',
        ));

  void resetState() {
    emit(AuthState(
      isLoading: false,
      phoneNumber: '',
      dailCode: '',
      verificationId: '',
      password: '',
      confirmPassword: '',
    ));
  }

  void _emitState() => emit(AuthState(
        isLoading: state.isLoading,
        phoneNumber: state.phoneNumber,
        dailCode: state.dailCode,
        password: state.password,
        verificationId: state.verificationId,
        confirmPassword: state.confirmPassword,
      ));

  void authenticate(
      {required String phoneNumber, required String dailCode}) async {
    state.phoneNumber = dailCode + phoneNumber;
    authServiceImp.phoneAuth(phoneNumber: phoneNumber, dailCode: dailCode);
  }

  void saveID({required String verificationId}) async {
    state.verificationId = verificationId;
    _emitState();
  }

  void googleAuth() async => authServiceImp.googleAuth();

  void validateOtp({required String otp}) async {
    authServiceImp.validateOtp(token: state.verificationId, otp: otp);
  }

  void addDeviceToken({required String token}) async =>
      authServiceImp.addDeviceToken(token: token);

  void resendOtp() async => authServiceImp.phoneAuth(
      phoneNumber: state.phoneNumber, dailCode: state.dailCode);

  void updateToken({required String token}) async {
    state.verificationId = token;
    _emitState();
  }
}
