import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:simple_moments/dependency/get_it.dart';
import 'package:simple_moments/firebase_options.dart';
import 'package:simple_moments/ui/auth/auth_cubit.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<AndroidNotificationChannel> channel() async {
  return const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', //Title
      description: 'This channel is used for notifications.',
      importance: Importance.max,
      playSound: true,
      enableVibration: true);
}

void showNotification({required RemoteNotification? notification}) async {
  if (notification != null) {
    AndroidNotificationChannel globalChannel = await channel();

    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          globalChannel.id,
          globalChannel.name,
          channelDescription: globalChannel.description,
          importance: Importance.max,
          priority: Priority.max,
          playSound: true,
          enableVibration: true,
          icon: 'launch_background',
        ),
      ),
    );
  }
}

@pragma('vm:entry-point')
Future<void> onBackgroundMessage(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  PushNotificationService().createChannel();
}

class PushNotificationService {
  final _firebaseMessaging = FirebaseMessaging.instance;

  void addToken() async {
    await _firebaseMessaging.getToken().then((token) {
      if (token != null) {

      }
    });
  }

  setNotifications() async {
    _firebaseMessaging.requestPermission();

    await _firebaseMessaging.setForegroundNotificationPresentationOptions(
        alert: true, badge: true, sound: true);

    FirebaseMessaging.onBackgroundMessage(onBackgroundMessage);

    FirebaseMessaging.onMessage.listen(
      (message) async {
        showNotification(notification: message.notification);
      },
    );

    FirebaseMessaging.instance.onTokenRefresh.listen(
        (event) => getItInstance<AuthCubit>().addDeviceToken());
  }

  createChannel() async {
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');

    DarwinInitializationSettings initializationSettingsIOS =
        const DarwinInitializationSettings();

    InitializationSettings initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(await channel());

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }
}
