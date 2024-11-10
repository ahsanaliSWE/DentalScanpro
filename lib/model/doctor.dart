class Doctor {
  final String name;
  final String specialty;
  final String location;
  final String phone;
  final String email;
  final Map<String, String> timing; // Map for available appointments
  final String image; // Assuming an image field is stored as URL/path in Firestore

  Doctor({
    required this.name,
    required this.specialty,
    required this.location,
    required this.phone,
    required this.email,
    required this.timing,
    required this.image,
  });

  // Factory method to create a Doctor instance from Firestore data
  factory Doctor.fromMap(Map<String, dynamic> data) {
    return Doctor(
      name: data['name'] ?? '',
      specialty: data['specialty'] ?? '',
      location: data['location'] ?? '',
      phone: data['phone'] ?? '',
      email: data['email'] ?? '',
      timing: Map<String, String>.from(data['timing'] ?? {}),
      image: data['image'] ?? '',
    );
  }

  // Method to convert Doctor object to a Map for Firestore storage
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'specialty': specialty,
      'location': location,
      'phone': phone,
      'email': email,
      'timing': timing,
      'image': image,
    };
  }
}
