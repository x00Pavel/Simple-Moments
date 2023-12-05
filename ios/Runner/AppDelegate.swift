
import UIKit
import Flutter
import Firebase
import FirebaseCore
import FirebaseMessaging
import UserNotifications

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate, MessagingDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
   FirebaseApp.configure()
      if #available(iOS 10.0, *) {
        UNUserNotificationCenter.current().delegate = self as UNUserNotificationCenterDelegate
      }

      Messaging.messaging().delegate = self
      UNUserNotificationCenter .current().delegate = self
      UNUserNotificationCenter .current().requestAuthorization(options: [.alert, .sound, .badge ]) {
          success, _ in guard success else {
              return
          }
      }
      application.registerForRemoteNotifications()
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        messaging.token{ token, _ in
            guard token != nil else{
            return
        }
        }
    }
}
