import 'package:flutter/material.dart';

class MathChapterScreen extends StatelessWidget {
  final List<String> Mathchapters = [
    "Trigonometric functions",
    "Trigonometric functions of Compound Angles",
    "Factorization Formulae",
    "Straight Line",
    "Circle and Conics",
    "Sets",
    "Relations and Functions",
    "Probability",
    "Sequences and series"
    "Mathematical Logic",
    "Matrices",
    "Trigonometric functions",
    "Pair of straight lines",
    "Circle",
    "Conics",
    "Vectors",
    "Three-dimensional geometry",
    "Line",
    "Plane",
    "Linear programming problems",
    "Continuity",
    "Differentiation",
    "Applications of derivative",
    "Integration",
    "Applications of definite integral",
    "Statistics",
    "Probability distribution",
    "Bernoulli trials and Binomial distribution"
  ];

  @override
  Widget build(BuildContext context) {

    final Map<String, String> args = ModalRoute.of(context)!.settings.arguments as Map<String, String>;

    final String username = args['username']??"Unknown";
    final String testType = args['testType']??"Unknown";
    final String subjectId = args['subjectId']??"Unknown";

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Topic'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Select Chapter',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: Mathchapters.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: _buildChapterButton(context, Mathchapters[index],username, testType, subjectId, Mathchapters[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChapterButton(BuildContext context, String chapter,String username, String testType, String subjectId, String chapt) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, '/selectDifficulty',arguments: {'username': username, 'testType': testType, 'subjectId': subjectId, 'chapt': chapt});  // Navigate to test interface for the selected chapter
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 5,
        ),
        child: Text(
          chapter,
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
