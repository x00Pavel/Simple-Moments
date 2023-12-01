import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:simple_moments/api_service/app_config/app_config.dart';
import 'package:simple_moments/api_service/service.dart';
import 'package:simple_moments/database/database.dart';
import 'package:simple_moments/ui/auth/auth_cubit.dart';
import 'package:simple_moments/ui/auth/auth_service.dart';
import 'package:simple_moments/ui/nav_screens/camera_moments/moments_cubit.dart';
import 'package:simple_moments/ui/nav_screens/home/home_cubit.dart';
import 'package:simple_moments/ui/nav_screens/home/home_service.dart';
import 'package:simple_moments/ui/nav_screens/profile/profile_cubit.dart';
import 'package:simple_moments/ui/nav_screens/profile/profile_service.dart';

import 'navigation/navigation_service.dart';

final getItInstance = GetIt.I;

Future initDependencies(AppConfig appConfig) async {
  var securedStorage = const FlutterSecureStorage();

  // Network
  final dio = Dio();
  getItInstance.registerLazySingleton<Dio>(() => dio);

  // Storage
  getItInstance.registerSingleton<FlutterSecureStorage>(securedStorage);

  //Build configurations
  getItInstance.registerSingleton<AppConfig>(appConfig);

  // Services
  getItInstance.registerLazySingleton<NavigationServiceImpl>(
      () => NavigationServiceImpl());

  getItInstance.registerLazySingleton<TempDatabaseImpl>(
      () => TempDatabaseImpl(securedStorage: getItInstance()));

  getItInstance.registerLazySingleton<ServiceHelpersImp>(() =>
      ServiceHelpersImp(
          dio: getItInstance(), tempDatabaseImpl: getItInstance()));

  getItInstance.registerLazySingleton<AuthServiceImp>(() => AuthServiceImp(
      serviceHelpersImp: getItInstance(), tempDatabaseImpl: getItInstance()));

  getItInstance.registerLazySingleton<HomeServiceImp>(() => HomeServiceImp(
      serviceHelpersImp: getItInstance(), tempDatabaseImpl: getItInstance()));

  getItInstance.registerLazySingleton<ProfileServiceImp>(() =>
      ProfileServiceImp(
          serviceHelpersImp: getItInstance(),
          tempDatabaseImpl: getItInstance()));

  // Cubits
  getItInstance
      .registerFactory(() => AuthCubit(authServiceImp: getItInstance()));

  getItInstance
      .registerFactory(() => HomeCubit(homeServiceImp: getItInstance()));

  getItInstance.registerFactory(() => ProfileCubit(
      profileServiceImp: getItInstance(), tempDatabaseImpl: getItInstance()));

  getItInstance
      .registerFactory(() => MomentCubit(homeServiceImp: getItInstance()));
}
