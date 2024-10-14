import 'package:flutter/material.dart';

class SelectMockFltTest extends StatelessWidget {
  final List<String> tests = [
    'Test 1',
    'Test 2',
    'Test 3',
    'Test 4',
    'Test 5',
    'Test 6',
    'Test 7',
    'Test 8',
    'Test 9',
    'Test 10',
    'Test 11',
    'Test 12',
    'Test 13',
    'Test 14',
    'Test 15',
  ];

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>?;

    // Default to 'Unknown' if any argument is missing
    final String username = args?['username'] ?? 'Unknown';
    final String testType = args?['testType'] ?? 'Unknown';
    final String flttype = args?['flttype'] ?? 'Unknown';

    return Scaffold(
      appBar: AppBar(
        title:
            Text('username: $username, testType: $testType, flttype: $flttype'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Title
            const Text(
              'Select Test',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20), // Space between title and the list

            // Expanded ListView for scrollable tests
            Expanded(
              child: ListView.builder(
                itemCount: tests.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      _buildTestButton(context, tests[index], username,
                          testType, flttype, testType + flttype + tests[index]),
                      const SizedBox(height: 20), // Space between buttons
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to create buttons for each test
  Widget _buildTestButton(BuildContext context, String label, String username,
      String testType, String flttype, String testId) {
      
      double screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      width: screenWidth * 0.8, // 80% of screen width
      child: ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(
          context,
          '/mockflttestinterface', // Assuming this is the next screen route
          arguments: {
            'username': username,
            'testType': testType,
            'flttype': flttype,
            'testId': testId, // Pass the selected testId
          },
        );
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 20), // Button height
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15), // Rounded corners
        ),
        elevation: 5, // 3D effect
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 18), // Button text size
      ),
    ), 
    );
  }
}
