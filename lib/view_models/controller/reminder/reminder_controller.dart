import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dentalscanpro/model/reminder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../../../utils/notification_service.dart';

class ReminderController extends GetxController {
  var reminders = <Reminder>[].obs;
  final String userId = FirebaseAuth.instance.currentUser?.uid ?? 'userID'; // Initialize user ID once

  @override
  void onInit() {
    super.onInit();
    loadReminders(); // Load reminders on initialization
  }

  // Load reminders from Firestore and schedule notifications
  Future<void> loadReminders() async {
    if (userId.isEmpty) {
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
        scheduleNotification(reminder);
      }
    } catch (e) {
      print('Failed to load reminders: $e');
      Get.snackbar('Error', 'Failed to load reminders: ${e.toString()}');
    }
  }

  // Add reminder with notification
  Future<void> addReminder(Reminder reminder) async {
    if (userId.isEmpty) {
      Get.snackbar('Error', 'User not authenticated');
      return;
    }

    try {
      var docRef = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('reminders')
          .add(reminder.toMap());

      reminders.add(reminder.copyWith(id: docRef.id));
      Get.snackbar('Success', 'Reminder added successfully');

      // Schedule a notification for the reminder
      scheduleNotification(reminder.copyWith(id: docRef.id));
    } catch (e) {
      print('Failed to add reminder: $e');
      Get.snackbar('Error', 'Failed to add reminder: ${e.toString()}');
    }
  }

  // Update reminder with notification
  Future<void> updateReminder(Reminder updatedReminder) async {
    if (userId.isEmpty) {
      Get.snackbar('Error', 'User not authenticated');
      return;
    }

    try {
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

        // Reschedule the notification for the updated reminder
        scheduleNotification(updatedReminder);
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
    if (userId.isEmpty) {
      Get.snackbar('Error', 'User not authenticated');
      return;
    }

    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('reminders')
          .doc(reminderId)
          .delete();

      reminders.removeWhere((reminder) => reminder.id == reminderId);
      Get.snackbar('Success', 'Reminder deleted successfully');

      // Cancel the corresponding notification
    } catch (e) {
      print('Failed to delete reminder: $e');
      Get.snackbar('Error', 'Failed to delete reminder: ${e.toString()}');
    }
  }

  // Schedule a notification for the reminder
  void scheduleNotification(Reminder reminder) {
    // Calculate the notification time (5 minutes before the reminder time)
    DateTime notificationTime = reminder.time.subtract(Duration(minutes: 5));

    NotificationService.showScheduledNotification(
      id: reminder.id.hashCode,
      title: "Reminder",
      body: "You have a reminder set for ${reminder.title} in 5 minutes.",
      scheduledDate: notificationTime,
    );
  }
}
