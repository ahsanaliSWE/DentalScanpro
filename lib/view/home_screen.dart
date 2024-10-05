import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dentalscanpro/view/notification_screen.dart';
import 'package:dentalscanpro/view/reminder_screen.dart';
import 'package:dentalscanpro/view/profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatelessWidget {
  final User? user = FirebaseAuth.instance.currentUser;

  String getGreeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    } else if (hour < 17) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
  }

  Future<String> getUserName() async {
    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user?.uid)
        .get();
    return userDoc['name'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[200],
          iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'DentalScan Pro',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => NotificationsScreen());
            },
            icon: const Icon(Icons.notifications, color: Colors.white),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: FutureBuilder<String>(
                future: getUserName(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text('Loading...');
                  } else if (snapshot.hasError) {
                    return Text('Error');
                  }
                  return Text(snapshot.data ?? 'User');
                },
              ),
              accountEmail: Text(user?.email ?? ''),
              currentAccountPicture: CircleAvatar(
              
                backgroundImage: NetworkImage(user?.photoURL ??
                    'https://www.example.com/default_profile_pic.jpg'),
              ),
              decoration: BoxDecoration(
                color: Colors.lightBlue[200],
              ),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: const Text('Profile'),
              onTap: () {
                Get.to(() => ProfileScreen());
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: const Text('Sign Out'),
              onTap: () {
                FirebaseAuth.instance.signOut();
                Get.offAllNamed('/login');
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 300,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
                color: Colors.lightBlue[200],
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 70,
                      backgroundImage: NetworkImage(user?.photoURL ??
                          'https://www.example.com/default_profile_pic.jpg'),
                    ),
                    const SizedBox(height: 20),
                    FutureBuilder<String>(
                      future: getUserName(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Text('Loading...');
                        } else if (snapshot.hasError) {
                          return const Text('Error');
                        }
                        String userName = snapshot.data ?? 'User';
                        
                        return Text(
                          '${getGreeting()}, $userName',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontFamily: 'Arial' ,
                              fontWeight: FontWeight.bold),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Get.to(() => ReminderScreen());
              },
              child: const Text('Set Reminders'),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Upcoming Reminders',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            // You can add the reminders list or other components here
          ],
        ),
      ),
    );
  }
}
