import 'dart:ui';
import 'package:dentalscanpro/firebase_options.dart';
import 'package:dentalscanpro/routes/routes.dart';
import 'package:dentalscanpro/view/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'utils/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await NotificationService.initialize();

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
        primarySwatch: Colors.lightBlue, // Main theme color
        scaffoldBackgroundColor: Colors.white,
        dialogTheme: DialogTheme(
          backgroundColor: Colors.white, // Background color of dialogs
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          titleTextStyle: const TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          contentTextStyle: const TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
        ),        
        datePickerTheme: DatePickerThemeData(
          backgroundColor: Colors.lightBlue[50],
          headerBackgroundColor: Colors.lightBlue[200],
          dayStyle: TextStyle(color: Colors.black),
          ),
        timePickerTheme: TimePickerThemeData(
          backgroundColor: Colors.lightBlue[50],
          dialHandColor: Colors.lightBlue[200],
          dialBackgroundColor: Colors.lightBlue[100],
          entryModeIconColor: Colors.black,
          hourMinuteColor: Colors.lightBlue[200],
          hourMinuteTextColor: Colors.white,
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Colors.black, // Color for Text Buttons
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
                color:
                    Color.fromARGB(255, 0, 0, 0)), // Border color when enabled
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
                color:
                    Color.fromARGB(255, 0, 0, 0)), // Border color when focused
            borderRadius: BorderRadius.circular(8),
          ),
          labelStyle: const TextStyle(
              color: Color.fromARGB(255, 0, 0, 0)), // Label color
          hintStyle: const TextStyle(
              color: Color.fromARGB(255, 0, 0, 0)), // Hint text color
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.lightBlue[200], // Button background color
            foregroundColor: Colors.white, // Button text color
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        textSelectionTheme: const TextSelectionThemeData(
            cursorColor: Color.fromARGB(255, 0, 0, 0)),
        progressIndicatorTheme: ProgressIndicatorThemeData(
          color: Colors.lightBlue[200], // CircularProgressIndicator color
        ),
      ),
      home: const SplashScreen(),
      getPages: AppRoutes.appRoutes(),
    );
  }
}
