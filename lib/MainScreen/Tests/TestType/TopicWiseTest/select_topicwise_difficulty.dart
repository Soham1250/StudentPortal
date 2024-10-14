import 'package:flutter/material.dart';

class SelectTopicWiseDifficultyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map<String, String> args = ModalRoute.of(context)!.settings.arguments as Map<String, String>;

    final String username = args['username']??"Unknown";
    final String testType = args['testType']??"Unknown";
    final String subjectId = args['subjectId']??"Unknown";
    final String chapt = args['chapt']??"Unknown";

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Difficulty'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center, // Center content vertically
          children: [
            const Text(
              'Select Difficulty',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30), // Space between title and buttons

            // Row 1: Easy and Medium
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                    child: _buildDifficultyButton(
                        context,
                        'Easy',
                        Icons.check_circle,
                        Colors.green,
                        '/selectTopicWiseTest',
                        username,
                        testType,
                        subjectId,
                        chapt,
                        'easy')),
                const SizedBox(width: 20), // Space between buttons
                Expanded(
                    child: _buildDifficultyButton(
                        context,
                        'Medium',
                        Icons.trending_up,
                        Colors.orange,
                        '/selectTopicWiseTest',
                        username,
                        testType,
                        subjectId,
                        chapt,
                        'medium')),
              ],
            ),
            const SizedBox(height: 20), // Space between rows

            // Row 2: Hard and Mixed
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                    child: _buildDifficultyButton(
                        context,
                        'Hard',
                        Icons.whatshot,
                        Colors.red,
                        '/selectTopicWiseTest',
                        username,
                        testType,
                        subjectId,
                        chapt,
                        'hard')),
                const SizedBox(width: 20), // Space between buttons
                Expanded(
                    child: _buildDifficultyButton(
                        context,
                        'Mixed',
                        Icons.shuffle,
                        Colors.blue,
                        '/selectTopicWiseTest',
                        username,
                        testType,
                        subjectId,
                        chapt,
                        'mixed')),
              ],
            ),

            Text(
                'username: $username, testType: $testType, subjectId: $subjectId, chapt: $chapt'),
          ],
        ),
      ),
    );
  }

  // Helper method to create buttons for each difficulty
  Widget _buildDifficultyButton(
    BuildContext context,
    String label,
    IconData icon,
    Color color,
    String route,
    String username,
    String testType,
    String subjectId,
    String chapt,
    String difficulty,
  ) {
    return ElevatedButton.icon(
      onPressed: () {
        Navigator.pushNamed(context, '/selectTopicWiseTest', arguments: {
          'username': username,
          'testType': testType,
          'subjectId': subjectId,
          'chapt': chapt,
          'difficulty': difficulty,
        }); // Navigate to respective difficulty test
      },
      icon:
          Icon(icon, color: Colors.white, size: 30), // Icon for the difficulty
      label: Text(label, style: const TextStyle(fontSize: 18)),
      style: ElevatedButton.styleFrom(
        backgroundColor: color, // Background color
        padding: const EdgeInsets.symmetric(vertical: 20), // Button size
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15), // Rounded corners
        ),
        elevation: 5, // 3D effect for buttons
      ),
    );
  }
}
