import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_service.dart';

class AuthState {
  bool isLoading;
  String phoneNumber;
  String verificationId, password, confirmPassword;

  AuthState({
    required this.isLoading,
    required this.phoneNumber,
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
          phoneNumber: '',
          verificationId: '',
          password: '',
          confirmPassword: '',
        ));

  void resetState() {
    emit(AuthState(
      isLoading: false,
      phoneNumber: '',
      verificationId: '',
      password: '',
      confirmPassword: '',
    ));
  }

  void _emitState() => emit(AuthState(
        isLoading: state.isLoading,
        phoneNumber: state.phoneNumber,
        password: state.password,
        verificationId: state.verificationId,
        confirmPassword: state.confirmPassword,
      ));

  void authenticate({required String phoneNumber}) async {
    state.phoneNumber = phoneNumber;
    authServiceImp.phoneAuth(phoneNumber: phoneNumber);
  }

  void googleAuth() async => authServiceImp.googleAuth();

  void validateOtp({required String otp}) async {
    authServiceImp.validateOtp(token: state.verificationId, otp: otp);
  }

  void resendOtp() async =>
      authServiceImp.phoneAuth(phoneNumber: state.phoneNumber);

  void saveID({required String verificationId}) async {
    state.verificationId = verificationId;
    _emitState();
  }


  void addDeviceToken() async {
    _emitState();
    authServiceImp.addDeviceToken();
  }

  void getUserCountry() async {
    authServiceImp.getUserCountry();
  }

}
