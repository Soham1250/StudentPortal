import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For date and time formatting

class NewGrievanceScreen extends StatefulWidget {
  @override
  _NewGrievanceScreenState createState() => _NewGrievanceScreenState();
}

class _NewGrievanceScreenState extends State<NewGrievanceScreen> {
  final TextEditingController _grievanceController = TextEditingController();

  @override
  Widget build(BuildContext context) {

     final args = ModalRoute.of(context)!.settings.arguments as Map<String, String>?;
    final String username = args?["username"] ?? 'Unknown';
    // Get screen width for button sizing
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Submit New Grievance'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Title for text box
            const Text(
              'Let us know what is bothering you',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            // Text box for entering the grievance
            Expanded(
              child: TextField(
                controller: _grievanceController,
                maxLines: 10, // Allows the text box to be scrollable
                decoration: InputDecoration(
                  hintText: 'Describe your grievance here...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Buttons for "Back" and "Submit"
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Back button
                SizedBox(
                  width: screenWidth * 0.4, // 40% of screen width
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // Go back to the previous screen
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 20), backgroundColor: Colors.redAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ), // Color for back button
                    ),
                    child: const Text('Back', style: TextStyle(fontSize: 18)),
                  ),
                ),
                // Submit button
                SizedBox(
                  width: screenWidth * 0.4, // 40% of screen width
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle the submission of the grievance
                      if (_grievanceController.text.isNotEmpty) {
                        // Generate grievance ID based on current date, time, and username
                        String grievanceId = _generateGrievanceId(username);

                        // Show the pop-up dialog with the generated grievance ID
                        _showGrievanceDialog(grievanceId);

                        _grievanceController.clear(); // Clear the text box after submission
                      } else {
                        // Show an error if the text box is empty
                        _showErrorDialog();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 20), backgroundColor: Colors.greenAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ), // Color for submit button
                    ),
                    child: const Text('Submit', style: TextStyle(fontSize: 18)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Method to generate grievance ID
  String _generateGrievanceId(String username) {
    final DateTime now = DateTime.now();
    final String formattedDate = DateFormat('yyyyMMdd').format(now); // Format: yyyyMMdd
    final String formattedTime = DateFormat('HHmmss').format(now);   // Format: HHmmss
    return '$formattedDate$formattedTime-$username';
  }

  // Method to show the grievance ID pop-up dialog
  void _showGrievanceDialog(String grievanceId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("We've got your grievance"),
          content: Column(
            mainAxisSize: MainAxisSize.min,  // Adjust dialog size
            children: [
              Text('Your Grievance ID is: $grievanceId'),
              const SizedBox(height: 20),
              const Text("We're looking into it, relax."),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  // Method to show an error dialog if text box is empty
  void _showErrorDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: const Text('Please enter your grievance before submitting.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
