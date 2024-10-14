import 'package:flutter/material.dart';

class StatisticsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, String>?;

    // Safely handle null and provide a default username if not provided
    final String username = args?['username'] ?? 'Unknown';

    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Statistics'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Hello $username, All the statistics here are based on your test performance.',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),

            // Strongest Subject
            _buildStatisticsButton(
              context, 
              'Strongest Subject: Physics \n You can always improve!', 
              Colors.green, 
              screenWidth, 
              username, 
              'strong',  // Subject Type
              'physics',  // Subject ID
            ),
            const SizedBox(height: 20),

            // Needs Revision
            _buildStatisticsButton(
              context, 
              'Needs Revision: Chemistry\n Try hard champ!', 
              Colors.orange, 
              screenWidth, 
              username, 
              'revision',  // Subject Type
              'chemistry',  // Subject ID
            ),
            const SizedBox(height: 20),

            // Weakest Subject
            _buildStatisticsButton(
              context, 
              'Weakest Subject: Mathematics\n The start is always difficult.', 
              Colors.red, 
              screenWidth, 
              username, 
              'weak',  // Subject Type
              'mathematics',  // Subject ID
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to create buttons for statistics and pass parameters
  Widget _buildStatisticsButton(
    BuildContext context, 
    String label, 
    Color color, 
    double screenWidth,
    String username, 
    String subjectType, 
    String subjectID,
  ) {
    return SizedBox(
      width: screenWidth * 0.9,  // Button takes 90% of the screen width
      child: ElevatedButton(
        onPressed: () {
          // Navigate to the SubjectReviewScreen with required parameters
          Navigator.pushNamed(
            context,
            '/subjectreview',
            arguments: {
              'username': username,
              'subjectType': subjectType,
              'subjectID': subjectID,
            },
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: const EdgeInsets.symmetric(vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),  // Rounded corners
          ),
          elevation: 5,
        ),
        child: Text(
          label,
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
