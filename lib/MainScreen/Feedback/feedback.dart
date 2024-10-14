import 'package:flutter/material.dart';

class FeedbackScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, String>?;
    final String username = args?["username"] ?? 'Unknown';

    // Get the screen width to set button size dynamically
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Feedback'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,  // Center the elements vertically
          crossAxisAlignment: CrossAxisAlignment.stretch,  // Stretch widgets to fill the available width
          children: [
            const Text(
              'Let us know how we can improve',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),  // Space between the title and the text box

            // Feedback text box
            const Expanded(
              child: TextField(
                maxLines: null,  // Allows multiple lines for feedback
                expands: true,   // Expands to fill available space
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter your feedback here...',
                ),
              ),
            ),
            const SizedBox(height: 30),  // Space between the text box and buttons

            // Buttons for Back and Submit
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Back button
                SizedBox(
                  width: screenWidth * 0.4,  // Set the button width to 40% of the screen width
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);  // Navigate back to the previous screen
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),  // Rounded corners
                      ),
                    ),
                    child: const Text('Back'),
                  ),
                ),
                
                // Submit button
                SizedBox(
                  width: screenWidth * 0.4,  // Set the button width to 40% of the screen width
                  child: ElevatedButton(
                    onPressed: () {
                      // Display the thank you message with the username in the pop-up
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Thank You!'),
                            content: Text('Your feedback has been submitted, $username.'),
                            actions: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);  // Close the pop-up
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),  // Rounded corners
                      ),
                    ),
                    child: const Text('Submit'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
