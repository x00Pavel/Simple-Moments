import 'dart:async';

import 'package:simple_moments/api_service/service.dart';

abstract class ProfileService {
  Future<void> getMonthlySales();
}

class ProfileServiceImp extends ProfileService {
  ServiceHelpersImp serviceHelpersImp;

  ProfileServiceImp({required this.serviceHelpersImp});

  @override
  Future<void> getMonthlySales() async {
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
}
