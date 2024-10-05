import 'package:dentalscanpro/view_models/controller/notification/notification_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationsScreen extends StatelessWidget {
  final NotificationController _notificationController = Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Notifications'),
      ),
      body: Obx(() {
        return ListView.builder(
          itemCount: _notificationController.notifications.length,
          itemBuilder: (context, index) {
            final notification = _notificationController.notifications[index];
            return ListTile(
              title: Text(notification.title ?? 'No Title'),
              subtitle: Text(notification.body ?? 'No Body'),
              trailing: Text(notification.source), // Show the source (reminder/push)
              leading: Icon(
                notification.source == 'reminder' ? Icons.alarm : Icons.notifications,
              ),
              onTap: () {
                // Optional: Navigate to a detailed view of the notification
              },
            );
          },
        );
      }),
    );
  }
}
