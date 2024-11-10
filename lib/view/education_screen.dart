import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EducationScreen extends StatefulWidget {
  const EducationScreen({super.key});

  @override
  State<EducationScreen> createState() => EducationState();
}

class EducationState extends State<EducationScreen> {

  Widget buildButton(IconData icon, String label) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            fixedSize: const Size(60, 60), // Adjust size as needed
          ),
          child: Icon(icon, size: 24),
        ),
        const SizedBox(height: 5),
        Text(label),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[200],
        title: const Text(
          'Educational Resources',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: Color.fromARGB(255, 255, 255, 255), size: 28), // Customize icon color and size
          onPressed: () {
            Get.back(); 
          },
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
              child: Container(
                height: 280,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        buildButton(Icons.abc, "Button 1"),
                        buildButton(Icons.abc, "Button 2"),
                        buildButton(Icons.abc, "Button 3"),
                        buildButton(Icons.abc, "Button 4"),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        buildButton(Icons.abc, "Button 5"),
                        buildButton(Icons.abc, "Button 6"),
                        buildButton(Icons.abc, "Button 7"),
                        buildButton(Icons.abc, "Button 8"),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 5,
                shadowColor: Colors.grey.withOpacity(0.5),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Dental Care Tips & Tricks',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.lightBlue[800],
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        '1. Brush your teeth twice a day for at least two minutes each time.',
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        '2. Use fluoride toothpaste to help strengthen tooth enamel and prevent decay.',
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        '3. Floss daily to remove plaque and food particles from between your teeth.',
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        '4. Visit your dentist regularly for check-ups and cleanings.',
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        '5. Limit sugary and acidic foods and drinks to prevent tooth decay.',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}