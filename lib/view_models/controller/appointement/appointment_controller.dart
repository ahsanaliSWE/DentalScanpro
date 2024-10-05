import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dentalscanpro/model/doctor.dart';

class AppointmentController extends GetxController {
  var doctors = <Doctor>[].obs; // Full list of doctors
  var filteredDoctors = <Doctor>[].obs; // Filtered list based on search query
  var searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchDoctors(); // Fetch doctors when the controller is initialized
  }

  // Fetch doctors from Firestore
  void fetchDoctors() async {
    try {
      var snapshots = await FirebaseFirestore.instance.collection('dentists').get();
      var doctorsList = snapshots.docs.map((doc) => Doctor.fromMap(doc.data())).toList();
      doctors.assignAll(doctorsList); // Assign the full doctor list
      filteredDoctors.assignAll(doctorsList); // Initially, filtered doctors is the same as the full list
    } catch (e) {
      print("Error fetching doctors: $e");
    }
  }

  // Filter doctors based on the search query
  void filterDoctors(String query) {
    searchQuery.value = query;
    if (query.isEmpty) {
      filteredDoctors.assignAll(doctors); // Show all doctors if search query is empty
    } else {
      filteredDoctors.assignAll(
        doctors.where((doctor) {
          // Check if the doctor's name or specialty contains the search query (case-insensitive)
          return doctor.name.toLowerCase().contains(query.toLowerCase()) ||
                 doctor.specialty.toLowerCase().contains(query.toLowerCase());
        }).toList(),
      );
    }
  }
}
