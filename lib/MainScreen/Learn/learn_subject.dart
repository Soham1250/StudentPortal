import 'package:flutter/material.dart';

class LearnSubjectScreen extends StatelessWidget {
  final Map<String, List<String>> chapterData = {
    'physics': [
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
    ],
    'chemistry': [
      "Solid State",
      "Chemical Thermodynamics and Energetic",
      "Electrochemistry",
      "General Principles and Processes of Isolation",
      "Solutions and Colligative Properties",
      "p-Block elements",
      "Group 15 elements",
      "d and f Block Elements",
      "Chemical Kinetics",
      "Coordination Compounds",
      "Halogen Derivatives of Alkanes (and arenes)",
      "Aldehydes",
      "Ketones and Carboxylic Acids",
      "Organic Compounds Containing Nitrogen",
      "Alcohols",
      "Phenols and Ether Alcohol",
      "Polymers",
      "Chemistry in Everyday Life",
      "Biomolecules Carbohydrates",
      "Some basic concepts of chemistry",
      "States of matter: Gasses and liquids",
      "Redox reaction",
      "Surface chemistry",
      "Nature of chemical bond",
      "Hydrogen",
      "s-Block elements (Alkali and alkaline earth metals)",
      "Fundamental concepts and methods in organic chemistry",
      "Alkanes",
    ],
    'mathematics': [
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
    ],
    'biology': [
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
    ]
  };

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>?;

    final String username = args?['username'] ?? 'Unknown';
    final String subjectID = args?['subjectID'] ?? 'Unknown';

    // Fetch the chapters based on the subjectID
    final List<String> chapters = chapterData[subjectID] ?? [];

    // Debugging: Log the subjectID and chapters
    Text('Subject ID: $subjectID, Chapters: $chapters');

    return Scaffold(
      appBar: AppBar(
        title: Text('$subjectID Chapters'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Hello, $username. What would you like to learn in $subjectID today?',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            // Expanded to make the list scrollable
            Expanded(
              child: chapters.isNotEmpty
                  ? ListView.builder(
                      itemCount: chapters.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            _buildChapterButton(
                                context,
                                chapters[index],
                                '/learnchapter',
                                username,
                                subjectID,
                                chapters[index]),
                            const SizedBox(height: 10),
                          ],
                        );
                      },
                    )
                  : Center(
                      child: Text(
                        'No chapters available for $subjectID',
                        style: const TextStyle(fontSize: 18, color: Colors.red),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to create a button for each chapter
  Widget _buildChapterButton(BuildContext context, String chapterName,
      String route, String username, String subjectID, String chapterID) {
    double screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      width: screenWidth * 0.8,
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(
            context,
            route,
            arguments: {
              'username': username,
              'subjectID': subjectID,
              'chapterID': chapterID, // Correcting the key to 'chapterID'
            },
          );
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 5,
        ),
        child: Text(
          chapterName,
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
