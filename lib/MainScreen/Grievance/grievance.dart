import 'package:flutter/material.dart';

class GrievancePortal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, String>?;
    final String username = args?["username"] ?? 'Unknown';
    // Get screen width dynamically
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Grievance Portal'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center, // Center content vertically
          crossAxisAlignment:
              CrossAxisAlignment.center, // Center content horizontally
          children: [
            const Text(
              'Grievance Portal',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40), // Space after title

            // Button for submitting a new grievance
            SizedBox(
              width: screenWidth * 0.8, // 80% width of the screen
              child: ElevatedButton.icon(
                icon: const Icon(Icons.create, size: 24), // Icon for the button
                label: const Text(
                  'Submit a New Grievance',
                  style: TextStyle(fontSize: 18),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/newgrievance',
                      arguments: {'username': username});
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  backgroundColor: Colors.blueAccent, // Button height
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // Rounded corners
                  ), // Button color
                  elevation: 5,
                ),
              ),
            ),
            const SizedBox(
                height: 20), // Space between buttons // Space between buttons

            // Button for checking grievance status
            SizedBox(
              width: screenWidth * 0.8, // 80% width of the screen
              child: ElevatedButton.icon(
                icon: const Icon(Icons.check_circle,
                    size: 24), // Icon for the button
                label: const Text(
                  'Check Grievance Status',
                  style: TextStyle(fontSize: 18),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/managegrievance',
                      arguments: {'username': username});
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  backgroundColor: Colors.greenAccent, // Button height
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // Rounded corners
                  ), // Button color
                  elevation: 5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
