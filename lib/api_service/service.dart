import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:simple_moments/database/database.dart';
import 'package:simple_moments/dependency/get_it.dart';
import 'package:simple_moments/utils/helpers.dart';

import 'app_config/app_config.dart';

String _baseUrl = getItInstance<AppConfig>().baseUrl;

void _showLog(dynamic data) {
  return getItInstance<AppConfig>().isDev
      ? globaLog('Response', jsonEncode(data))
      : '';
}

typedef EitherResponse = Future<Either<DioException, Response>>;

abstract class ServiceHelpers {
  EitherResponse post({
    required String endPointUrl,
    Map<String, dynamic>? body,
    Map<String, dynamic>? query,
  });

  EitherResponse postFormData(
      {required String endPointUrl, required FormData formData});

  EitherResponse get({
    required String endPointUrl,
    Map<String, dynamic>? body,
    Map<String, dynamic>? query,
  });

  EitherResponse put({
    required String endPointUrl,
    Map<String, dynamic>? body,
    Map<String, dynamic>? query,
  });

  EitherResponse patch({
    required String endPointUrl,
    required Map<String, dynamic> body,
  });

  EitherResponse delete(
      {required String endPointUrl, Map<String, dynamic>? query});
}

class ServiceHelpersImp extends ServiceHelpers {
  Dio dio;
  TempDatabaseImpl tempDatabaseImpl;

  BaseOptions options = BaseOptions(
      baseUrl: _baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 10), // 10 seconds
      receiveTimeout: const Duration(seconds: 10) // 10 seconds
      );

  ServiceHelpersImp({required this.dio, required this.tempDatabaseImpl});

  @override
  EitherResponse post(
      {required String endPointUrl,
      Map<String, dynamic>? body,
      Map<String, dynamic>? query}) async {
    dio = Dio(options);

    try {
      Response response = await dio.post(
        endPointUrl,
        data: jsonEncode(body),
        queryParameters: query,
        options: Options(
          validateStatus: (_) => true,
          headers: {
            'accept': '*/*',
            'Content-Type': 'application/json',
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.authorizationHeader:
                'Bearer ${await getItInstance<TempDatabaseImpl>().getUserToken()}'
          },
        ),
      );

      _showLog(response.data);
      return right(response);
    } on DioException catch (exception) {
      return left(exception);
    }
  }

  @override
  EitherResponse postFormData(
      {required String endPointUrl, required FormData formData}) async {
    dio = Dio(options);

    try {
      Response response = await dio.post(
        '$_baseUrl$endPointUrl',
        data: formData,
        options: Options(
          validateStatus: (_) => true,
          headers: {
            'accept': '*/*',
            'Content-Type': 'application/json',
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.authorizationHeader:
                'Bearer ${await getItInstance<TempDatabaseImpl>().getUserToken()}'
          },
        ),
      );
      _showLog(response.data);
      return right(response);
    } on DioException catch (exception) {
      return left(exception);
    }
  }

  @override
  EitherResponse put(
      {required String endPointUrl,
      Map<String, dynamic>? body,
      Map<String, dynamic>? query}) async {
    dio = Dio(options);

    try {
      Response response = await dio.put(endPointUrl,
          queryParameters: query,
          data: jsonEncode(body),
          options: Options(validateStatus: (_) => true, headers: {
            'accept': '*/*',
            'Content-Type': 'application/json',
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.authorizationHeader:
                'Bearer ${await getItInstance<TempDatabaseImpl>().getUserToken()}'
          }));

      _showLog(response.data);
      return right(response);
    } on DioException catch (exception) {
      return left(exception);
    }
  }

  @override
  EitherResponse patch(
      {required String endPointUrl, required Map<String, dynamic> body}) async {
    dio = Dio(options);

    try {
      Response response = await dio.patch(
        endPointUrl,
        data: jsonEncode(body),
        options: Options(validateStatus: (_) => true, headers: {
          'accept': '*/*',
          'Content-Type': 'application/json',
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader:
              'Bearer ${await getItInstance<TempDatabaseImpl>().getUserToken()}'
        }),
      );
      _showLog(response.data);
      return right(response);
    } on DioException catch (exception) {
      return left(exception);
    }
  }

  @override
  EitherResponse delete(
      {required String endPointUrl, Map<String, dynamic>? query}) async {
    dio = Dio(options);

    try {
      Response response = await dio.delete(endPointUrl,
          queryParameters: query,
          options: Options(validateStatus: (_) => true, headers: {
            'accept': '*/*',
            'Content-Type': 'application/json',
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.authorizationHeader:
                'Bearer ${await getItInstance<TempDatabaseImpl>().getUserToken()}'
          }));
      _showLog(response.data);
      return right(response);
    } on DioException catch (exception) {
      return left(exception);
    }
  }

  @override
  EitherResponse get(
      {required String endPointUrl,
      Map<String, dynamic>? body,
      Map<String, dynamic>? query}) async {
    dio = Dio(options);

    try {
      Response response = await dio.get(endPointUrl,
          queryParameters: query,
          options: Options(validateStatus: (_) => true, headers: {
            'accept': '*/*',
            'Content-Type': 'application/json',
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.authorizationHeader:
                'Bearer ${await getItInstance<TempDatabaseImpl>().getUserToken()}'
          }));
      _showLog(response.data);
      return right(response);
    } on DioException catch (exception) {
      return left(exception);
    }
  }
}
