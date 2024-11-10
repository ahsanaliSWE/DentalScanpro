import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final User? user = FirebaseAuth.instance.currentUser;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController dobController = TextEditingController();

  File? _profileImage;
  final picker = ImagePicker();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    loadUserProfile();
  }

  Future<void> loadUserProfile() async {
    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user?.uid)
        .get();
    setState(() {
      nameController.text = userDoc['name'];
      dobController.text = userDoc['dob'];
    });
  }

  Future<void> updateProfile() async {
    if (user != null) {
      setState(() {
        isLoading = true;
      });

      try {
        // Update profile picture if selected
        String? profileImageUrl;
        if (_profileImage != null) {
          final storageRef = FirebaseStorage.instance
              .ref()
              .child('profile_pictures')
              .child('${user!.uid}.jpg');
          await storageRef.putFile(_profileImage!);
          profileImageUrl = await storageRef.getDownloadURL();
        }

        // Update Firestore with new data
        await FirebaseFirestore.instance.collection('users').doc(user?.uid).update({
          'name': nameController.text,
          'dob': dobController.text,
          if (profileImageUrl != null) 'profile_picture': profileImageUrl,
        });

        if (profileImageUrl != null) {
          await user?.updatePhotoURL(profileImageUrl);
        }

        await user?.updateDisplayName(nameController.text);

        Get.snackbar('Success', 'Profile updated successfully');
      } catch (e) {
        Get.snackbar('Error', e.toString());
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  Future<void> pickProfileImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.lightBlue[200],
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: Color.fromARGB(255, 255, 255, 255), size: 28), // Customize icon color and size
          onPressed: () {
            Get.back(); // Go back to the previous screen
          },
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: pickProfileImage,
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: _profileImage != null
                          ? FileImage(_profileImage!)
                          : NetworkImage(user?.photoURL ??
                              'https://www.example.com/default_profile_pic.jpg') as ImageProvider,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: dobController,
                    decoration: InputDecoration(
                      labelText: 'Date of Birth',
                      hintText: 'MM/DD/YYYY',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                      );
                      if (pickedDate != null) {
                        String formattedDate = '${pickedDate.month}/${pickedDate.day}/${pickedDate.year}';
                        setState(() {
                          dobController.text = formattedDate;
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: updateProfile,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightBlue[200],
                    ),
                    child: const Text('Update Profile'),
                  ),
                ],
              ),
            ),
    );
  }
}
