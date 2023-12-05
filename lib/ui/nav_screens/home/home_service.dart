import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http_parser/http_parser.dart';
import 'package:simple_moments/api_service/service.dart';
import 'package:simple_moments/database/database.dart';
import 'package:simple_moments/database/moments_model/moments_model.dart';
import 'package:simple_moments/dependency/navigation/global_routes.dart';
import 'package:simple_moments/dependency/navigation/navigator_routes.dart';
import 'package:simple_moments/utils/helpers.dart';
import 'package:simple_moments/utils/loader_dialog.dart';

import 'home_cubit.dart';

abstract class HomeService {
  Future<List<Moment>> getMoments();

  Future<void> uploadMoment({required String imagePath});
}

class HomeServiceImp extends HomeService {
  ServiceHelpersImp serviceHelpersImp;
  TempDatabaseImpl tempDatabaseImpl;

  HomeServiceImp(
      {required this.serviceHelpersImp, required this.tempDatabaseImpl});

  @override
  Future<List<Moment>> getMoments() async {
    List<Moment> moments = [];

    var response = await serviceHelpersImp.get(
        endPointUrl: 'user/videos/${await tempDatabaseImpl.getUserToken()}');

    response.fold((left) => null, (right) {
      if (right.statusCode == 200) {
        moments = momentsModelFromJson(jsonEncode(right.data)).moments;
      }
    });
    return moments;
  }

  @override
  Future<void> uploadMoment({required String imagePath}) async {
    showLoaderDialog();

    var formData = FormData.fromMap({
      'user_id': await tempDatabaseImpl.getUserToken(),
      'file': await MultipartFile.fromFile(imagePath,
          filename: 'image.name', contentType: MediaType('video', 'mp4'))
    });

    var response = await serviceHelpersImp.postFormData(
        endPointUrl: 'user/upload', formData: formData);

    globalPop();

    response.fold((left) => debugPrint(left.message), (right) {
      if (right.statusCode == 200) {
        buildContext.read<HomeCubit>().getMoments();
        globalNavigateUntil(route: Routes.domain);
        globalToast('Moments uploaded');
      }
    });
  }
}
