import 'package:flutter/material.dart';

class LearnScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, String>?;

    final String username = args?['username']??'Unknown';

    // Get the screen width to set button size dynamically
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Learn'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center, // Center the elements vertically
          crossAxisAlignment: CrossAxisAlignment
              .stretch, // Stretch widgets to fill the available width
          children: [
            // Title for the Learn page
            const Text(
              'What would you like to learn today?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
                height: 30), // Space between title and subject selection

            // Subject selection title
            const Text(
              'Select Subject',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
                height: 20), // Space between subject title and buttons

            // Grid layout for subject buttons
            Expanded(
              child: GridView.count(
                crossAxisCount: 2, // Two columns
                crossAxisSpacing: 20, // Space between columns
                mainAxisSpacing: 20, // Space between rows
                children: [
                  // Physics button
                  _buildSubjectButton(context, '/learnsubject', Icons.science,
                      screenWidth, username, 'physics'),
                  // Chemistry button
                  _buildSubjectButton(context, '/learnsubject', Icons.biotech,
                      screenWidth, username, 'chemistry'),
                  // Mathematics button
                  _buildSubjectButton(context, '/learnsubject', Icons.calculate,
                      screenWidth, username, 'mathematics'),
                  // Biology button
                  _buildSubjectButton(context, '/learnsubject', Icons.eco,
                      screenWidth, username, 'biology'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build subject buttons
  Widget _buildSubjectButton(
    BuildContext context,
    String route,
    IconData icon,
    double screenWidth,
    String username,
    String subjectID,
  ) {
    return SizedBox(
      width: screenWidth * 0.4, // Set button width to 40% of the screen width
      child: ElevatedButton.icon(
        onPressed: () {
          Navigator.pushNamed(
        context, 
        route,
        arguments: {
          'username': username,
          'subjectID': subjectID,
          },
        );  
        },
        icon: Icon(icon, size: 30, color: Colors.white),
        label: Text(subjectID),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 20), // Button height
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15), // Rounded corners
          ),
          elevation: 5, // Button shadow
        ),
      ),
    );
  }
}
