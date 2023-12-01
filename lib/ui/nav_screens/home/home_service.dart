import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http_parser/http_parser.dart';
import 'package:simple_moments/api_service/service.dart';
import 'package:simple_moments/database/database.dart';
import 'package:simple_moments/dependency/navigation/navigator_routes.dart';
import 'package:simple_moments/ui/nav_screens/camera_moments/moments_cubit.dart';
import 'package:simple_moments/utils/loader_dialog.dart';

abstract class HomeService {
  Future<void> getMoments();

  Future<void> uploadMoment({required String imagePath});
}

class HomeServiceImp extends HomeService {
  ServiceHelpersImp serviceHelpersImp;
  TempDatabaseImpl tempDatabaseImpl;

  HomeServiceImp(
      {required this.serviceHelpersImp, required this.tempDatabaseImpl});

  @override
  Future<void> getMoments() async {
    // var response = await serviceHelpersImp.post(
    //     endPointUrl: '/auth/customer/send/otp', body: body);
    //
    //
    // response.fold((left) => globalToast('Sorry, an error occurred'), (right) {
    //   if (right.statusCode == 200) {
    //     globalToast(right.data['message']);
    //     // globalNavigateUntil(route: Routes.login);
    //   }
    // });
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
        endPointUrl: 'upload', formData: formData);

    globalPop();

    response.fold((left) => null, (right) {
      if (right.statusCode == 200) {
        globalPop();
        globalPop();
        buildContext.read<MomentCubit>().getMoments();
        // tempDatabaseImpl.saveUserData(userData: jsonEncode(right.data['data']));
      }
    });
  }
}
