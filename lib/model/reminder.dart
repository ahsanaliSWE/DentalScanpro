import 'package:cloud_firestore/cloud_firestore.dart';

class Reminder {
  String? id;
  String title;
  DateTime time;
  bool isEnabled;
  bool isMissed; 

  Reminder({
    this.id,
    required this.title,
    required this.time,
    this.isEnabled = true,
    this.isMissed = false, 
  });

  // Convert to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'time': Timestamp.fromDate(time), // Convert DateTime to Timestamp
      'isEnabled': isEnabled,
      'isMissed': isMissed,
    };
  }

  // Create Reminder from Firestore document
  factory Reminder.fromMap(Map<String, dynamic> map, String id) {
    return Reminder(
      id: id,
      title: map['title'] ?? '',
      time: (map['time'] as Timestamp).toDate(), // Convert Timestamp to DateTime
      isEnabled: map['isEnabled'] ?? true,
      isMissed: map['isMissed'] ?? false, 
    );
  }

  Reminder copyWith({
    String? id,
    String? title,
    DateTime? time,
    bool? isEnabled,
    bool? isMissed,
  }) {
    return Reminder(
      id: id ?? this.id,
      title: title ?? this.title,
      time: time ?? this.time,
      isEnabled: isEnabled ?? this.isEnabled,
      isMissed: isMissed ?? this.isMissed,
    );
  }
}
