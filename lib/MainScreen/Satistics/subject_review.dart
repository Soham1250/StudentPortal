import 'package:flutter/material.dart';

class SubjectReviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Retrieve the parameters passed to this screen
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, String>;

    final String username = args['username']??"Unknown";
    final String subjectType = args['subjectType']??"Unknown";
    final String subjectID = args['subjectID']??"Unknown";

    // Define dynamic messages based on the subject type
    String title = '';
    String message = '';
    String buttonText = 'Go to Notes';

    switch (subjectType) {
      case 'strong':
        title = 'Strongest Subject';
        message = 'You have mastered $subjectID. Keep up the great work!';
        break;
      case 'revision':
        title = 'Needs Revision';
        message = 'Practice makes perfect! You should revisit $subjectID.';
        break;
      case 'weak':
        title = 'Weakest Subject';
        message = 'You have room for improvement in $subjectID. Let\'s work on it!';
        break;
      default:
        message = 'Unknown subject status';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('$title - $subjectID'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Hello, $username.',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 40),
            // Go to Notes Button
            ElevatedButton(
              onPressed: () {
                // Navigate to the notes or relevant screen
                Navigator.pushNamed(context, '/learnsubject', arguments: {
                  'username': username,
                  'subjectID': subjectID,
                });
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 5,
              ),
              child: Text(buttonText, style: const TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}
