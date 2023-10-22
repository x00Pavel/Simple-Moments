import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'api_service/app_config/app_config.dart';
import 'dependency/get_it.dart';
import 'index.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies(devMode);

  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // await dotenv.load(fileName: '.env');

  // PushNotificationService()
  //   ..createChannel()
  //   ..setNotifications();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const Index());
  });
}
