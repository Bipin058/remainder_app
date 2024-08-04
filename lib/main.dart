import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';

import 'services/notification_service.dart';
import 'services/alarm_service.dart';
import 'screens/home_screen.dart';
import 'models/medicine.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Notification Service
  await NotificationService().init();

  // Request necessary permissions
  await _requestPermissions();

  // Initialize Alarm Service
  AlarmService().init();

  runApp(MyApp());
}

Future<void> _requestPermissions() async {
  await [
  //  Permission.vibrate,
    Permission.notification,
    Permission.ignoreBatteryOptimizations,
   // Permission.receiveBootCompleted,
    //Permission.wakeLock,
  ].request();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MedicineProvider(),
      child: MaterialApp(
        title: 'Medicine Reminder App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomeScreen(),
      ),
    );
  }
}
