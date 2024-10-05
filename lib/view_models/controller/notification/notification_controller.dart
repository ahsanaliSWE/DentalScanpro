import 'package:dentalscanpro/model/notification.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  // List of all notifications
  var notifications = <NotificationMessage>[].obs;

  // Add a new notification to the list
  void addNotification(NotificationMessage notification) {
    notifications.insert(0, notification); // Insert at the beginning for most recent
  }
}
