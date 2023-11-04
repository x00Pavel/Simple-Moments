import 'dart:developer';

import 'package:change_case/change_case.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:pinput/pinput.dart';
import 'package:simple_moments/database/database.dart';
import 'package:simple_moments/dependency/get_it.dart';
import 'package:simple_moments/dependency/navigation/global_router_exports.dart';
import 'package:simple_moments/dependency/navigation/navigator_routes.dart';
import 'package:simple_moments/utils/size_config.dart';

import 'colors.dart';
import 'text_styles.dart';

void globalToast(String message) => Fluttertoast.showToast(
    msg: message.toUpperFirstCase(),
    backgroundColor: Colors.black,
    textColor: Colors.white,
    fontSize: 15);

void globaLog(String topic, message) => log('$topic $message');

Gap globalGap(double gap) => Gap(gap.heightAdjusted);

PinTheme pinTheme() {
  return PinTheme(
    width: 56,
    height: 56,
    textStyle: regularText(fontSize: 16, color: Colors.white),
    decoration: BoxDecoration(
        border: Border.all(color: kTextFieldStroke),
        borderRadius: BorderRadius.circular(8)),
  );
}

void checkStatus() async {
  try {
    await getItInstance<TempDatabaseImpl>().getUserData().then((userData) {
      if (userData.isNotEmpty) {
        globalNavigateTo(route: Routes.domain);
      } else {
        globalNavigateUntil(route: Routes.domain);
      }
    });
  } catch (_) {}
}


extension FormValidator on GlobalKey<FormState> {
  bool get validate => formValidator(this);
}

bool formValidator(GlobalKey<FormState> globalKey) {
  return globalKey.currentState!.validate();
}