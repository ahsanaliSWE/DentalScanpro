import 'package:dentalscanpro/model/notification.dart';
import 'package:dentalscanpro/view_models/controller/notification/notification_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    // Request permission for notifications
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    final NotificationController _notificationController = Get.put(NotificationController());

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Message received: ${message.notification?.title}');

      // Add push notification to the shared list
      _notificationController.addNotification(
        NotificationMessage(
          title: message.notification?.title,
          body: message.notification?.body,
          timestamp: DateTime.now(),
          source: 'push',
        ),
      );
    });


    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }

    // Obtain the FCM token
    final fcmToken = await _firebaseMessaging.getToken();
    print('FCM Token: $fcmToken');

    // Initialize push notification listeners
    initPushNotification();
  }

  void handleMessage(RemoteMessage? message) {
    if (message == null) {
      return;
    }

    print('New message received: ${message.notification?.title}');
    print('Message body: ${message.notification?.body}');

    // Navigate to a specific screen based on the message
    /* navigatorKey.currentState?.pushNamed(
      '/notifications', 
      arguments: message,
    ); */
  }

  Future<void> initPushNotification() async {
    // Handle background messages
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);

    // Handle messages when the app is in the foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Message received in foreground: ${message.notification?.title}');
      // You can also trigger a local notification here
    });

    // Handle when the app is opened by tapping on a notification
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
  }
}
