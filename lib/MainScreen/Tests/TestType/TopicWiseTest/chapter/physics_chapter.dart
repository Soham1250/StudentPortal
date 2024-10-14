import 'package:flutter/material.dart';

class PhysicsChapterScreen extends StatelessWidget {
  final List<String> Phychapters = [
    "Circular motion",
    "Rotational motion",
    "Oscillations",
    "Gravitation",
    "Elasticity",
    "Electrostatics",
    "Wave Motion",
    "Magnetism",
    "Surface Tension",
    "Wave Theory of Light",
    "Stationary Waves",
    "Kinetic Theory of Gases and Radiation",
    "Interference and Diffraction",
    "Current Electricity",
    "Magnetic Effects of Electric Current",
    "Electromagnetic Inductions",
    "Electrons and Photons",
    "Atoms",
    "Molecules",
    "Nuclei",
    "Semiconductors",
    "Communication Systems",
    "Measurements",
    "Scalars and Vectors",
    "Force",
    "Friction in solids and liquids",
    "Refraction of Light",
    "Ray optics",
    "Magnetic effect of electric current",
    "Magnetism",
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
          crossAxisAlignment: CrossAxisAlignment.stretch,  // Make sure children stretch to fill width
          children: [
            const Text(

              'Select Chapter',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),  // Space between title and list
            
            // Scrollable list of chapters
            Expanded(
              child: ListView.builder(
                itemCount: Phychapters.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),  // Space between buttons
                    child: _buildChapterButton(context, Phychapters[index],username, testType, subjectId, Phychapters[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to create chapter buttons
  Widget _buildChapterButton(BuildContext context, String chapter,String username, String testType, String subjectId, String chapt) {
    return SizedBox(
      width: double.infinity,  // Makes the button fill the full width
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, '/selectDifficulty',arguments: {'username': username, 'testType': testType, 'subjectId': subjectId, 'chapt': chapt});  // Navigate to test interface for the selected chapter
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 20),  // Button height
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),  // Rounded corners
          ),
          elevation: 5,  // 3D effect
        ),
        child: Text(
          chapter,
          style: const TextStyle(fontSize: 18),  // Font size for button text
        ),
      ),
    );
  }
}
