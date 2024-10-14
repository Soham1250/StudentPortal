import 'package:flutter/material.dart';

class PerformanceScreen extends StatelessWidget {
  final List<String> testList = [
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
  ]; // Add more test names as required

  @override
  Widget build(BuildContext context) {

    final args = ModalRoute.of(context)!.settings.arguments as Map<String, String>?;
    final String username = args?['username'] ?? 'Unknown';
    
    // Get the screen width
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Performance So Far...'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Here are your latest 10 test results:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            // The scrollable ListView to display the tests
            Expanded(
              child: ListView.builder(
                itemCount: testList.length > 10 ? 10 : testList.length, // Limit to 10 tests
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: SizedBox(
                      width: screenWidth * 0.8, // Each button will take 80% of screen width
                      child: ElevatedButton(
                        onPressed: () {
                          // Navigate to detailed analysis with the specific testId
                          Navigator.pushNamed(
                            context,
                            '/detailedanalysis', // Navigate to the detailed analysis page
                            arguments: {
                              'username': username, // Replace with actual username
                              'testId': testList[index], // Pass the test ID (Test 1, Test 2, etc.)
                            },
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: Text(
                          testList[index],
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
