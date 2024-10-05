import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Rxn<User> firebaseUser = Rxn<User>();
  final RxBool isLoading = false.obs;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  @override
  void onInit() {
    super.onInit();
    firebaseUser.bindStream(_auth.authStateChanges());
    firebaseUser.listen((user) {
      if (user != null) {
        Get.offAllNamed('/nav_menu'); 
      }
    });
  }

  Future<void> register(String name, String email, String password, String confirmPassword) async {
  if (password != confirmPassword) {
    Get.snackbar('Error', 'Passwords do not match');
    return;
  }

  try {
    isLoading.value = true;
    await _auth.createUserWithEmailAndPassword(email: email, password: password);
    await _firestore.collection('users').doc(_auth.currentUser?.uid).set({
      'name': name,
      'email': email,
      'created_at': Timestamp.now(),
    });
    Get.snackbar('Success', 'Registration Successful');
    Get.offAllNamed('/nav_menu');  
  } catch (e) {
    Get.snackbar('Error', e.toString());
  } finally {
    isLoading.value = false;
  }
}


  // Email & Password Sign-In
  Future<void> login(String email, String password) async {
    try {
      isLoading.value = true;
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Get.snackbar('Success', 'Login Successful');
      Get.offAllNamed('/nav_menu');
     
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // Email & Password Sign-Up
  Future<void> signUp(String email, String password) async {
    try {
      isLoading.value = true;
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      Get.snackbar('Success', 'Account Created Successfully');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // Password Reset
  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      Get.snackbar('Success', 'Password Reset Email Sent');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  // Google Sign-In
Future<void> googleSignIn() async {
  try {
    isLoading.value = true;

    // Step 1: Initiate Google Sign-In
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) {
      // User cancelled the sign-in
      isLoading.value = false;
      return;
    }

    // Step 2: Authenticate and get Google credentials
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Step 3: Sign in to Firebase using the Google credentials
    UserCredential userCredential = await _auth.signInWithCredential(credential);
    User? user = userCredential.user;

    // Step 4: Check if the user exists in Firestore and update or create a new profile
    if (user != null) {
      // Retrieve Google account information
      final String name = googleUser.displayName ?? 'N/A';
      final String email = googleUser.email;
      final String profilePic = googleUser.photoUrl ?? '';

      // Check if the user already has a profile in Firestore
      final DocumentSnapshot userDoc = await _firestore.collection('users').doc(user.uid).get();

      if (!userDoc.exists) {
        // Create a new user profile if it doesn't exist
        await _firestore.collection('users').doc(user.uid).set({
          'name': name,
          'email': email,
          'dob': '', // Empty DOB field for Google Sign-In users
          'profile_picture_url': profilePic, // Store the Google profile picture
          'created_at': Timestamp.now(),
          'updated_at': Timestamp.now(),
        });
      } else {
        // Optionally update user profile information
        await _firestore.collection('users').doc(user.uid).update({
          'name': name,
          'email': email,
          'profile_picture_url': profilePic, // Update the profile picture if it changed
          'updated_at': Timestamp.now(),
        });
      }
      Get.snackbar('Success', 'Google Sign-In Successful');
    }
  } catch (e) {
    Get.snackbar('Error', e.toString());
  } finally {
    isLoading.value = false;
  }
}


  // Sign-Out
  Future<void> signOut() async {
    try {
      await _auth.signOut();
      Get.snackbar('Success', 'Logged Out');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

   Future<void> createUserProfile(String uid, String name, String email, String dob, XFile? profileImage) async {
    try {
      String? profilePicUrl;

      // Upload profile picture if provided
      if (profileImage != null) {
        final Reference storageRef = _storage.ref().child('profile_pictures').child(uid);
        final UploadTask uploadTask = storageRef.putFile(File(profileImage.path));
        final TaskSnapshot snapshot = await uploadTask;
        profilePicUrl = await snapshot.ref.getDownloadURL();
      }

      // Save user profile to Firestore
      await _firestore.collection('users').doc(uid).set({
        'name': name,
        'email': email,
        'dob': dob,
        'profile_picture_url': profilePicUrl ?? '', // Save profile picture URL if exists
        'created_at': Timestamp.now(),
        'updated_at': Timestamp.now(),
      });
      
      Get.snackbar('Success', 'Profile created successfully');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> saveReminder(String uid, String title, DateTime dateTime, bool isCustom) async {
    try {
      await _firestore.collection('users').doc(uid).collection('reminders').add({
        'title': title,
        'date_time': dateTime.toIso8601String(),
        'is_custom': isCustom,
      });
      
      Get.snackbar('Success', 'Reminder saved');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  
}

