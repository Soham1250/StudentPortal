import 'package:flutter/material.dart';

class BiologyChapterScreen extends StatelessWidget {
  final List<String> Biochapters = [
    "Biochemistry of cell",
    "Diversity in organisms",
    "Plant Growth and Development",
    "Plant Water Relations and Mineral Nutrition",
    "Genetic Basis of Inheritance",
    "Gene: its nature",
    "Expression and regulation",
    "Biotechnology: Process and Application",
    "Enhancement in Food Production",
    "Microbes in Human Welfare",
    "Photosynthesis",
    "Respiration",
    "Reproduction in Plants",
    "Organisms and Environment-Il",
  ];

  @override
  Widget build(BuildContext context) {
    final Map<String, String> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;

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
                itemCount: Biochapters.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: _buildChapterButton(context, Biochapters[index],username, testType, subjectId, Biochapters[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChapterButton(BuildContext context, String chapter,
      String username, String testType, String subjectId, String chapt) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, '/selectDifficulty', arguments: {
            'username': username,
            'testType': testType,
            'subjectId': subjectId,
            'chapt': chapt
          }); // Navigate to test interface for the selected chapter
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
