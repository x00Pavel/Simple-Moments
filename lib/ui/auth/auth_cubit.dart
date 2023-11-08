import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_service.dart';

class AuthState {
  bool isLoading;
  String phoneNumber;
  String token, password, confirmPassword;

  AuthState({
    required this.isLoading,
    required this.phoneNumber,
    required this.password,
    required this.confirmPassword,
    required this.token,
  });
}

class AuthCubit extends Cubit<AuthState> {
  AuthServiceImp authServiceImp;

  AuthCubit({required this.authServiceImp})
      : super(AuthState(
            isLoading: false,
            phoneNumber: '',
            password: '',
            confirmPassword: '',
            token: ''));

  void resetState() {
    emit(AuthState(
        isLoading: false,
        phoneNumber: '',
        password: '',
        confirmPassword: '',
        token: ''));
  }

  void _emitState() => emit(AuthState(
      isLoading: state.isLoading,
      phoneNumber: state.phoneNumber,
      password: state.password,
      confirmPassword: state.confirmPassword,
      token: state.token));

  void authenticate(
      {required String phoneNumber, required String dailCode}) async {
    state.phoneNumber = dailCode + phoneNumber;
    authServiceImp.authenticate(phoneNumber: phoneNumber, dailCode: dailCode);
    _emitState();
  }

  void googleAuth() async => authServiceImp.googleAuth();

  void validateOtp({required String otp}) async {
    authServiceImp.validateOtp(token: state.token, otp: otp);
  }

  void addDeviceToken({required String token}) async =>
      authServiceImp.addDeviceToken(token: token);

  void resendOtp() async {
    authServiceImp.resendOtp(
      phoneNumber: state.phoneNumber.substring(4),
      dailCode: state.phoneNumber.substring(0, 4),
    );
  }

  void collectPassword({
    String? password,
    String? confirmPassword,
  }) {
    if (password != null) {
      state.password = password;
    }
    if (confirmPassword != null) {
      state.confirmPassword = confirmPassword;
    }
    _emitState();
  }

  void updateToken({required String token}) async {
    state.token = token;
    _emitState();
  }
}
