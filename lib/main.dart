import 'dart:io';
import 'dart:ui';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:dentalscanpro/api/firebase_api.dart';
import 'package:dentalscanpro/firebase_options.dart';
import 'package:dentalscanpro/routes/routes.dart';
import 'package:dentalscanpro/view/home_screen.dart';
import 'package:dentalscanpro/view/login_screen.dart';
import 'package:dentalscanpro/view/splash_screen.dart';
import 'package:dentalscanpro/view/models/yolocam.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseApi().initNotifications();
  AwesomeNotifications().initialize(
    'resource://drawable/res_app_icon',
    [
      NotificationChannel(
        channelKey: 'reminder_channel',
        channelName: 'Reminder Notifications',
        channelDescription: 'Channel for Reminder Notifications',
        importance: NotificationImportance.High,
        defaultColor: Colors.blue,
        ledColor: Colors.white,
        playSound: true,
      )
    ],
    debug: true,
  );
  // Request notification permissions
  bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
  if (!isAllowed) {
    // Request user permission
    await AwesomeNotifications().requestPermissionToSendNotifications();
  }
  sendTestNotification();
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'DentalScan Pro',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
      getPages: AppRoutes.appRoutes(),
    );
  }
}

void sendTestNotification() async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: 1, // Unique ID for the notification
      channelKey: 'reminder_channel',
      title: 'Test Reminder',
      body: 'This is a test notification to verify the setup.',
      notificationLayout: NotificationLayout.Default,
    ),
  );
}
