import 'package:dentalscanpro/model/doctor.dart';
import 'package:dentalscanpro/view_models/controller/appointement/appointment_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class AppointmentScreen extends StatelessWidget {
  final AppointmentController controller = Get.put(AppointmentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Appointment Screen',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueAccent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 28),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) => controller.filterDoctors(value),
              decoration: InputDecoration(
                hintText: 'Search for a doctor',
                prefixIcon: const Icon(Icons.search, color: Colors.blueAccent),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.blueAccent, width: 1),
                  borderRadius: BorderRadius.circular(30),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.blueAccent, width: 2),
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              return ListView.builder(
                itemCount: controller.filteredDoctors.length,
                itemBuilder: (context, index) {
                  var doctor = controller.filteredDoctors[index];
                  return Card(
                    color: Colors.blueAccent[100],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(doctor.image),
                        radius: 30,
                      ),
                      title: Text(
                        doctor.name,
                        style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      subtitle: Text(doctor.specialty, style: const TextStyle(color: Colors.white70)),
                      onTap: () {
                        Get.to(() => DoctorDetailScreen(doctor: doctor));
                      },
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}

class DoctorDetailScreen extends StatelessWidget {
  final Doctor doctor;

  DoctorDetailScreen({required this.doctor});

  Future<void> _launchMap() async {
    final String googleMapsUrl = 'geo:0,0?q=${Uri.encodeComponent(doctor.location)}';
    final Uri uri = Uri.parse(googleMapsUrl);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      Get.snackbar("Error", "Could not open Google Maps. Please manually enter the location.");
    }
  }

  Future<void> _launchPhone() async {
    final Uri phoneUri = Uri(scheme: 'tel', path: doctor.phone);
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      Get.snackbar("Error", "Could not open phone dialer.");
    }
  }

  Future<void> _launchEmail() async {
    final Uri emailUri = Uri(scheme: 'mailto', path: doctor.email);
    
    if (await canLaunchUrl(emailUri)) {
      bool launched = await launchUrl(emailUri);
      if (!launched) {
        Get.snackbar("Error", "No email app is available to open this link.");
      }
    } else {
      Get.snackbar("Error", "Could not open email client.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          doctor.name,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blueAccent,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(doctor.image),
              radius: 60,
            ),
            const SizedBox(height: 16),
            Text(
              doctor.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blueAccent),
              textAlign: TextAlign.center,
            ),
            Text(
              doctor.specialty,
              style: const TextStyle(fontSize: 18, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Card(
              color: Colors.blueAccent[100],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      leading: Icon(Icons.location_on, color: Colors.white),
                      title: Text(doctor.location, style: const TextStyle(color: Colors.white)),
                      trailing: IconButton(
                        icon: Icon(Icons.map, color: Colors.white),
                        onPressed: _launchMap,
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.phone, color: Colors.white),
                      title: Text(doctor.phone, style: const TextStyle(color: Colors.white)),
                      trailing: IconButton(
                        icon: Icon(Icons.call, color: Colors.white),
                        onPressed: _launchPhone,
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.email, color: Colors.white),
                      title: Text(doctor.email, style: const TextStyle(color: Colors.white)),
                      trailing: IconButton(
                        icon: Icon(Icons.mail, color: Colors.white),
                        onPressed: _launchEmail,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Available Appointments:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const SizedBox(height: 8),
                  ...doctor.timing.entries.map((entry) {
                    return Text(
                      '${entry.key}: ${entry.value}',
                      style: const TextStyle(fontSize: 16, color: Colors.white70),
                    );
                  }).toList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
