import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class TempDatabaseService {
  Future<void> saveUserData({required String userData});

  Future<void> saveUserToken({required String token});

  Future<String> getUserData();

  Future<String> getUserToken();

  void clearUserData();
}

class TempDatabaseImpl extends TempDatabaseService {
  FlutterSecureStorage securedStorage;

  TempDatabaseImpl({required this.securedStorage});

  @override
  void clearUserData() async => await securedStorage.deleteAll();

  @override
  Future<String> getUserData() async =>
      await securedStorage.read(key: 'USER_DATA') ?? '';

  @override
  Future<void> saveUserData({required String userData}) async =>
      await securedStorage.write(key: 'USER_DATA', value: userData);

  @override
  Future<String> getUserToken() async =>
      await securedStorage.read(key: 'USER_TOKEN') ?? '';

  @override
  Future<void> saveUserToken({required String token}) async =>
      await securedStorage.write(key: 'USER_TOKEN', value: token);
}
