import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

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
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  PushNotificationService().createChannel();
}

class PushNotificationService {
  final _firebaseMessaging = FirebaseMessaging.instance;

  void addToken() async {
    await _firebaseMessaging.getToken().then((token) {
      if (token != null) {
        // getItInstance<AuthCubit>().addDeviceToken(token: token);
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
        // buildContext.read<OrderAndCartCubit>().getOrders(isLoading: false);
      },
    );

    // FirebaseMessaging.instance.onTokenRefresh.listen(
    //         (event) => getItInstance<AuthCubit>().addDeviceToken(token: event));

    FirebaseMessaging.onMessageOpenedApp.listen(
          (message) async {
        var payLoad = convertPayload(message.data.toString());
        // if (payLoad['notificationType'] == 'order')
        //   globalPushNotificationNavigation(
        //       initialRoute: Routes.domain,
        //       finalRoute: Routes.orderDetails,
        //       arguments: payLoad['orderId'].toString());
      },
    );

    addToken();
  }

  Map<String, dynamic> convertPayload(String payload) {
    final String load = payload.substring(1, payload.length - 1);
    List<String> split = [];

    load.split(',').forEach((String s) => split.addAll(s.split(': ')));
    Map<String, dynamic> mapped = {};
    for (int i = 0; i < split.length; i++) {
      if (i % 2 == 1) {
        mapped.addAll({split[i - 1].trim().toString(): split[i].trim()});
      }
    }
    return mapped;
  }

  createChannel() async {
    AndroidInitializationSettings initializationSettingsAndroid =
    const AndroidInitializationSettings('@mipmap/launcher_icon');

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
