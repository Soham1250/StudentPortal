import 'package:flutter/material.dart';

class TestSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Retrieve the username parameter
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, String>?;
    final String username = args?["username"]?? "Unknown"; 

    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Selection'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Center vertically
          crossAxisAlignment:
              CrossAxisAlignment.stretch, // Stretch buttons to fill width
          children: [
            Text(
              'Welcome, $username', // Display the passed username
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),

            // Button for Test-Wise Test
            _buildTestSelectionButton(
              label: 'Topic-Wise Test',
              context: context,
              route: '/topicWiseTest',
              username: username, // Pass the username
              testType: 'topicwise', // Pass testType as "topicwise"
            ),
            const SizedBox(height: 20), // Space between buttons

            // Button for Subject-Wise Test
            _buildTestSelectionButton(
              label: 'Subject-Wise Test',
              context: context,
              route: '/subjectWise',
              username: username,
              testType: 'subjectwise',
            ),
            const SizedBox(height: 20),
            // Button for Full Syllabus Test
            _buildTestSelectionButton(
              label: 'Full Syllabus Test',
              context: context,
              route: '/fullSyllabus',
              username: username,
              testType: 'fullsyllabus',
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to create test selection buttons
  Widget _buildTestSelectionButton({
    required String label,
    required BuildContext context,
    required String route,
    required String username,
    required String testType,
  }) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(
          context,
          route,
          arguments: {
            'username': username,
            'testType': testType,
          }, // Pass both username and testType as a Map
        ); // Navigate to respective test type
      },
      style: ElevatedButton.styleFrom(
        padding:
            const EdgeInsets.symmetric(vertical: 20), // Height of the button
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15), // Rounded corners
        ),
        elevation: 5, // Shadow for a 3D effect
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 18), // Button text size
      ),
    );
  }
}
