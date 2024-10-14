import 'package:flutter/material.dart';

class SelectFLTScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>?;

    // Default to 'Unknown' if any argument is missing
    final String username = args?['username'] ?? 'Unknown';
    final String testType = args?['testType'] ?? 'Unknown';

    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Full Length Test Selection \n username: $username, testType: $testType'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Center vertically
          crossAxisAlignment:
              CrossAxisAlignment.stretch, // Stretch buttons to fill width
          children: [
            // Button for "A randomly generated Full length test"
            _buildTestSelectionButton(
              label: 'Mock Full Length Test',
              context: context,
              route: '/mockflt',
              username: username,
              testType: testType,
              flttype: 'mock', // Example route
            ),
            const SizedBox(height: 20), // Space between buttons

            // Button for "Previous Year Test"
            _buildTestSelectionButton(
              label: 'Previous Year MHT CET Test',
              context: context,
              route: '/selectcetyear',
              username: username,
              testType: testType,
              flttype: 'previousYear',
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to create buttons for the tests
  Widget _buildTestSelectionButton({
    required String label,
    required BuildContext context,
    required String route,
    required String username,
    required String testType,
    required String flttype,
  }) {
    double screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      width: screenWidth * 0.8, // 80% of screen width
      child: ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, route, arguments: {
          'username': username,
          'testType': testType,
          'flttype': flttype
        }); // Navigate to respective test type
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 20), // Button height
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15), // Rounded corners
        ),
        elevation: 5, // Shadow for a 3D effect
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 18), // Button text size
      ),
    ),
    );
  }
}
