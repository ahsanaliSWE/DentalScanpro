import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class NotificationsScreen extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('All Notifications',style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('users')
            .doc(_auth.currentUser?.uid)
            .collection('notifications')
            .orderBy('timestamp', descending: true) // Order by latest notifications
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No notifications available."));
          }

          final notifications = snapshot.data!.docs;

          return ListView.builder(
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              var notification = notifications[index];
              var title = notification['title'] ?? "No Title";
              var body = notification['body'] ?? "No Details";
              var timestamp = notification['timestamp']?.toDate();
              var formattedTime = timestamp != null
                  ? DateFormat.yMMMd().add_jm().format(timestamp)
                  : "No Time";

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: ListTile(
                  title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(body),
                  trailing: Text(formattedTime, style: TextStyle(fontSize: 12, color: Color.fromARGB(255, 0, 0, 0))),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
