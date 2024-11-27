import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EducationScreen extends StatefulWidget {
  const EducationScreen({super.key});

  @override
  State<EducationScreen> createState() => EducationState();
}

class EducationState extends State<EducationScreen> {
   Widget buildCard(String title, IconData icon, String description,
      Color color, Function() onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 5,
        shadowColor: Colors.grey.withOpacity(0.5),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: color,
                    child: Icon(icon, color: Colors.white, size: 28),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                description,
                style: const TextStyle(fontSize: 16),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
  // Helper method to create buttons
  Widget buildButton(IconData icon, String label, Color color) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            Get.snackbar("Info", "You clicked on $label!");
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            fixedSize: const Size(60, 60),
          ),
          child: Icon(icon, size: 24, color: Colors.white),
        ),
        const SizedBox(height: 5),
        Text(label),
      ],
    );
  }
  
   void navigateToDetails(String title) {
    Get.to(() => DetailScreen(title: title));
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
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              color: Colors.white, size: 28),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Top Section with Buttons
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
                        buildButton(Icons.book, "Research", Colors.lightBlueAccent),
                        buildButton(Icons.video_library, "Videos", Colors.lightBlueAccent),
                        buildButton(Icons.article, "Articles", Colors.lightBlueAccent),
                        buildButton(Icons.quiz, "Quiz", Colors.lightBlueAccent),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        buildButton(Icons.report, "Reports", Colors.lightBlueAccent),
                        buildButton(Icons.school, "Courses", Colors.lightBlueAccent),
                        buildButton(Icons.web, "Websites", Colors.lightBlueAccent),
                        buildButton(Icons.forum, "Forums", Colors.lightBlueAccent),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            buildCard(
                "Research Insights",
                Icons.search,
                "Explore advanced dental care research powered by AI and deep learning techniques.",
                Colors.blue,
                () => navigateToDetails("Research Insights"),
              ),
              const SizedBox(height: 20),
              buildCard(
                "Dental Care Tips",
                Icons.health_and_safety,
                "Essential tips to maintain oral hygiene and prevent dental caries effectively.",
                Colors.green,
                () => navigateToDetails("Dental Care Tips"),
              ),
              const SizedBox(height: 20),
              buildCard(
                "Educational Videos",
                Icons.video_library,
                "Watch curated videos to understand dental care and treatment processes better.",
                Colors.orange,
                () => navigateToDetails("Educational Videos"),
              ),
              const SizedBox(height: 20),
              buildCard(
                "Interactive Quizzes",
                Icons.quiz,
                "Test your knowledge on dental health through fun and interactive quizzes.",
                Colors.purple,
                () => navigateToDetails("Interactive Quizzes"),
              ),

            // Dental Care Tips Section
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
                        '2. Use fluoride toothpaste to strengthen enamel and prevent decay.',
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

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
class DetailScreen extends StatelessWidget {
  final String title;

  const DetailScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.lightBlue[200],
      ),
      body: Center(
        child: Text(
          "Detailed content for $title.",
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}