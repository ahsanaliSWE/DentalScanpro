import 'package:dentalscanpro/model/doctor.dart';
import 'package:dentalscanpro/view_models/controller/appointement/appointment_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppointmentScreen extends StatelessWidget {
  final AppointmentController controller = Get.put(AppointmentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Appointment Screen'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) => controller.filterDoctors(value),
              decoration: InputDecoration(
                hintText: 'Search for a doctor',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              return ListView.builder(
                itemCount: controller.filteredDoctors.length, // Use filteredDoctors
                itemBuilder: (context, index) {
                  var doctor = controller.filteredDoctors[index];
                  return Card(
                    child: ListTile(
                      leading: Image.network(doctor.image), // Assuming image is a URL
                      title: Text(doctor.name),
                      subtitle: Text(doctor.specialty), // Display specialty or another field
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(doctor.name, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.network(doctor.image), // Assuming image is a URL
            SizedBox(height: 16),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.lightBlue[200],
                borderRadius: BorderRadius.circular(30),
                shape: BoxShape.rectangle,
                
              ),
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
              doctor.name,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,color: Colors.white),
            ),
            SizedBox(height: 8),
            Text(
              'Specialty: ${doctor.specialty}',
              style: TextStyle(fontSize: 18,color: Colors.white),
            ),
            SizedBox(height: 8),
            Text(
              'Location: ${doctor.location}',
              style: TextStyle(fontSize: 18,color: Colors.white),
            ),
            SizedBox(height: 8),
            Text(
              'Phone: ${doctor.phone}',
              style: TextStyle(fontSize: 18,color: Colors.white),
            ),
            SizedBox(height: 8),
            Text(
              'Email: ${doctor.email}',
              style: TextStyle(fontSize: 18,color: Colors.white),
            ),

          ],
         )
        ),
             Divider(
              color: Colors.black26,
                  height: 50,
                  thickness: 5,
                  indent: 10,
                  endIndent: 10,
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.lightBlue[200],
                borderRadius: BorderRadius.circular(30),
                shape: BoxShape.rectangle,
                
              ),
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
              'Available Appointments:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            ...doctor.availableAppointments.entries.map((entry) {
              return Text(
                '${entry.key}: ${entry.value}',
                style: TextStyle(fontSize: 16),
              );
            }).toList(),
                ]
            ),
           
            
          
        ),
          ],
      ),
      ),
    );
  }
}
