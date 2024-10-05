import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dentalscanpro/model/notification.dart';
import 'package:dentalscanpro/model/reminder.dart';
import 'package:dentalscanpro/view_models/controller/notification/notification_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ReminderController extends GetxController {
  var reminders = <Reminder>[].obs;
  String userId; // User's unique ID
  RxList<Reminder> missedReminders = RxList<Reminder>([]); // New list to track missed reminders
  final NotificationController _notificationController = Get.find();

  ReminderController(this.userId);

  @override
  void onInit() {
    super.onInit();
    loadReminders(); // Load reminders on initialization
  }

  
  Future<void> showReminderNotification(String title, String body) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: DateTime.now().millisecondsSinceEpoch.remainder(10000), // Unique ID
        channelKey: 'reminder_channel',
        title: title,
        body: body,
      ),
    );

    // Store the notification in the shared list
    _notificationController.addNotification(
      NotificationMessage(
        title: title,
        body: body,
        timestamp: DateTime.now(),
        source: 'reminder',
      ),
    );
  }

  // Add reminder with notification
  Future<void> addReminder(Reminder reminder) async {
    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId == null) {
        Get.snackbar('Error', 'User not authenticated');
        return;
      }

      var docRef = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('reminders')
          .add(reminder.toMap());

      reminders.add(reminder.copyWith(id: docRef.id));
      Get.snackbar('Success', 'Reminder added successfully');

      // Schedule a notification for the reminder
      await _scheduleNotification(reminder);
    } catch (e) {
      print('Failed to add reminder: $e');
      Get.snackbar('Error', 'Failed to add reminder: ${e.toString()}');
    }
  }

  // Update reminder with notification
  Future<void> updateReminder(Reminder updatedReminder) async {
    try {
      String? userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId == null) {
        Get.snackbar('Error', 'User not authenticated');
        return;
      }

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('reminders')
          .doc(updatedReminder.id)
          .update(updatedReminder.toMap());

      int index = reminders.indexWhere((reminder) => reminder.id == updatedReminder.id);
      if (index != -1) {
        reminders[index] = updatedReminder;
        reminders.refresh();
        Get.snackbar('Success', 'Reminder updated successfully');

        // Cancel existing notification and reschedule with the updated details
        await _cancelNotification(updatedReminder.id.hashCode);
        await _scheduleNotification(updatedReminder);
      } else {
        Get.snackbar('Error', 'Reminder not found in local list');
      }
    } catch (e) {
      print('Failed to update reminder: $e');
      Get.snackbar('Error', 'Failed to update reminder: ${e.toString()}');
    }
  }

  // Delete reminder from Firestore and cancel the notification
  Future<void> deleteReminder(String reminderId) async {
    try {
      String? userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId == null) {
        Get.snackbar('Error', 'User not authenticated');
        return;
      }

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('reminders')
          .doc(reminderId)
          .delete();

      reminders.removeWhere((reminder) => reminder.id == reminderId);
      Get.snackbar('Success', 'Reminder deleted successfully');

      // Cancel the corresponding notification
      await _cancelNotification(reminderId.hashCode);
    } catch (e) {
      print('Failed to delete reminder: $e');
      Get.snackbar('Error', 'Failed to delete reminder: ${e.toString()}');
    }
  }

  // Load reminders from Firestore
  Future<void> loadReminders() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      Get.snackbar('Error', 'User not authenticated');
      return;
    }

    try {
      var snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('reminders')
          .get();

      var reminderList = snapshot.docs
          .map((doc) => Reminder.fromMap(doc.data() as Map<String, dynamic>, doc.id))
          .toList();

      reminders.assignAll(reminderList);

      // Schedule notifications for all reminders on load
      for (var reminder in reminders) {
        await _scheduleNotification(reminder);
      }
    } catch (e) {
      print('Failed to load reminders: $e');
      Get.snackbar('Error', 'Failed to load reminders: ${e.toString()}');
    }
  }

  // Schedule a notification for a reminder
  Future<void> _scheduleNotification(Reminder reminder) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: reminder.id.hashCode,
        channelKey: 'reminder_channel',
        title: 'Reminder: ${reminder.title}',
        body: 'Scheduled at ${reminder.time}',
        notificationLayout: NotificationLayout.Default,
      ),
      schedule: NotificationCalendar.fromDate(date: reminder.time),
    );
  }

  // Cancel a notification for a reminder
  Future<void> _cancelNotification(int notificationId) async {
    await AwesomeNotifications().cancel(notificationId);
  }
}
