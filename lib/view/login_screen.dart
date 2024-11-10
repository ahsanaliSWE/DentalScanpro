import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:dentalscanpro/view_models/controller/auth/auth_controller.dart';

class LoginScreen extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _showResetPasswordDialog(BuildContext context) {
    final TextEditingController resetEmailController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Reset Password"),
          content: TextField(
            controller: resetEmailController,
            decoration: const InputDecoration(
              labelText: 'Enter your email',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                authController.resetPassword(resetEmailController.text.trim());
                Navigator.pop(context);
              },
              child: const Text("Send Reset Link"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 100),
              Center(
                child: Image.asset(
                  'assets/images/black_teeth_no_bg.png',
                  width: 150,
                ),
              ),
              Center(
                child: Image.asset(
                  'assets/images/black_text_no_bg.png',
                  width: 210,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color.fromRGBO(245, 245, 245, 1),
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: Colors.black,
                        width: 1), // Add border for enabled state
                    borderRadius: BorderRadius.circular(50),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: Colors.black,
                        width: 2), // Add border for focused state
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color.fromRGBO(245, 245, 245, 1),
                  labelText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: Colors.black,
                        width: 1), // Add border for enabled state
                    borderRadius: BorderRadius.circular(50),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: Colors.black,
                        width: 2), // Add border for focused state
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Obx(() => authController.isLoading.value
                  ? const CircularProgressIndicator()
                  : SizedBox(
                      width: 170,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromRGBO(110, 207, 228, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onPressed: () {
                          authController.login(
                            emailController.text.trim(),
                            passwordController.text.trim(),
                          );
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () {
                  _showResetPasswordDialog(
                      context); // Show reset password dialog
                },
                child: const Text(
                  'Forget Password!',
                  style: TextStyle(
                    color: Color.fromRGBO(110, 207, 228, 1),
                  ),
                ),
              ),
              const Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Divider(
                      thickness: 2,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      "OR",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      thickness: 2,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  authController.googleSignIn(); // Call Google Sign-In
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  side: BorderSide(color: Colors.grey.shade300, width: 1),
                  elevation: 0,
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FaIcon(FontAwesomeIcons.google, color: Colors.red),
                    SizedBox(width: 10),
                    Text(
                      'Sign In with Google',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Don\'t have an account?'),
                  TextButton(
                    onPressed: () {
                      Get.toNamed('/register');
                    },
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                        color: Color.fromRGBO(110, 207, 228, 1),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
