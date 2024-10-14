import 'package:flutter/material.dart';

class LearnChapterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Retrieve the arguments passed from the previous screen
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, String>?;

    final String username = args?['username'] ?? 'Unknown';
    final String subjectID = args?['subjectID'] ?? 'Unknown';
    final String chapterID = args?['chapterID'] ?? 'Unknown'; 


    return Scaffold(
      appBar: AppBar(
        title: Text('$chapterID in $subjectID'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Hello, $username',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'You are learning $chapterID in $subjectID.',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            // Add more content related to the chapter here
            Text(
              'Content for $chapterID goes here...',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
