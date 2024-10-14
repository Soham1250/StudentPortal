import 'package:flutter/material.dart';

class SubjectWiseTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final args = ModalRoute.of(context)!.settings.arguments as Map<String, String>?;

    // Default to 'Unknown' if any argument is missing
    final String username = args?['username'] ?? 'Unknown';
    final String testType = args?['testType'] ?? 'Unknown';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Subject-Wise Test'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,  // Center vertically
          crossAxisAlignment: CrossAxisAlignment.stretch,  // Stretch buttons to fill width
          children: [
            // Title
          Text(
              'Hello, $username\nTest Type: $testType',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 24,  // Font size for title
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),  // Spacing after title
            
            // Physics button
            _buildSubjectButton(context, 'Physics', '/selectSubjectWiseDifficulty',username, testType, 'physics'),
            const SizedBox(height: 20),  // Space between buttons

            // Mathematics button
            _buildSubjectButton(context, 'Mathematics', '/selectSubjectWiseDifficulty',username, testType, 'mathematics'),
            const SizedBox(height: 20),

            // Chemistry button
            _buildSubjectButton(context, 'Chemistry', '/selectSubjectWiseDifficulty',username, testType, 'chemistry'),
            const SizedBox(height: 20),

            // Biology button
            _buildSubjectButton(context, 'Biology', '/selectSubjectWiseDifficulty',username, testType, 'biology'),
          ],
        ),
      ),
    );
  }

  // Helper method to create buttons for each subject
  Widget _buildSubjectButton(BuildContext context, String subject, String route, String username, String testType, String subjectId) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(
        context, 
        route,
        arguments: {
          'username': username,
          'testType': testType,
          'subjectId': subjectId,
          },
        );  // Navigate to the respective subject topics screen
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 20),  // Button height
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),  // Rounded corners
        ),
        elevation: 5,  // 3D effect
      ),
      child: Text(
        subject,
        style: const TextStyle(fontSize: 18),  // Font size for button text
      ),
    );
  }
}
