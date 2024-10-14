import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class TestAnalysisScreen extends StatelessWidget {
  final List<Map<String, dynamic>> questions = [
    {
      'question': 'What is the determinant of the matrix [[2, 3], [1, 4]]?',
      'correctAnswer': '5',
    },
    {
      'question': 'Which of the following is an identity matrix?',
      'correctAnswer': '[[1, 0], [0, 1]]',
    },
    {
      'question': 'What is the trace of the matrix [[1, 2], [3, 4]]?',
      'correctAnswer': '5',
    },
    {
      'question': 'Matrix A is 2x3 and Matrix B is 3x2. What is the size of the resulting matrix when A is multiplied by B?',
      'correctAnswer': '2x2',
    },
    {
      'question': 'If A is a 3x3 matrix and det(A) = 4, what is det(2A)?',
      'correctAnswer': '32',
    },
    {
      'question': 'Which of the following is a scalar matrix?',
      'correctAnswer': '[[3, 0], [0, 3]]',
    },
    {
      'question': 'Which operation is required to invert a matrix?',
      'correctAnswer': 'Matrix adjugate',
    },
    {
      'question': 'What is the inverse of the matrix [[1, 0], [0, 1]]?',
      'correctAnswer': '[[1, 0], [0, 1]]',
    },
    {
      'question': 'Which matrix is a diagonal matrix?',
      'correctAnswer': '[[2, 0], [0, 3]]',
    },
    {
      'question': 'What is the rank of a 3x3 identity matrix?',
      'correctAnswer': '3',
    },
  ];

  @override
  Widget build(BuildContext context) {
    // Extract arguments from ModalRoute
    final Map<String, dynamic> args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    
    final String username = args['username']??'Unknown';
    final String testId = args['testId']??'Unknown';
    
    final List<String?> userResponses = List<String?>.from(args['answers']!);

    int correctCount = 0;
    int incorrectCount = 0;
    int unmarkedCount = 0;

    // Scores for graph
    final int topperScore = 10;
    final int averageScore = 6;
    final int lowestScore = 2;
    final int userScore = correctCount;

    List<Widget> resultWidgets = [];

    for (int i = 0; i < questions.length; i++) {
      String correctAnswer = questions[i]['correctAnswer'];
      String? userAnswer = userResponses[i];

      // Check if the user answered correctly
      if (userAnswer == correctAnswer) {
        correctCount++;
        resultWidgets.add(_buildResultWidget(
          context,
          questions[i]['question'],
          'Correct',
          Colors.green,
        ));
      } else if (userAnswer == null || userAnswer.isEmpty) {
        unmarkedCount++;
        resultWidgets.add(_buildResultWidget(
          context,
          questions[i]['question'],
          'Unanswered',
          Colors.grey,
        ));
      } else {
        incorrectCount++;
        resultWidgets.add(_buildResultWidget(
          context,
          questions[i]['question'],
          'Incorrect',
          Colors.red,
        ));
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Test Analysis - $testId'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Hello, $username. Here is your test analysis:',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Score summary
            Text(
              'Correct: $correctCount, Incorrect: $incorrectCount, Unanswered: $unmarkedCount',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),

            // Graph plotting
            Text(
              'Your Performance Compared to Others:',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: LineChart(
                LineChartData(
                  lineBarsData: [
                    LineChartBarData(
                      isCurved: true,
                      spots: [
                        FlSpot(2, lowestScore.toDouble()), // Lowest score
                        FlSpot(6, averageScore.toDouble()), // Average score
                        FlSpot(userScore.toDouble(), userScore.toDouble()), // User's score
                        FlSpot(10, topperScore.toDouble()), // Topper score
                      ],
                      dotData: FlDotData(show: true),
                      belowBarData: BarAreaData(show: false),
                      color: Colors.blue,  // Line color
                      barWidth: 3,
                    ),
                  ],
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: true),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          switch (value.toInt()) {
                            case 2:
                              return Text('Lowest');
                            case 6:
                              return Text('Average');
                            case 10:
                              return Text('Topper');
                            default:
                              return Text('');
                          }
                        },
                      ),
                    ),
                  ),
                  gridData: FlGridData(show: true),
                  borderData: FlBorderData(show: true),
                ),
              ),
            ),

            // List of questions with their statuses
            Expanded(
              child: ListView(
                children: resultWidgets,
              ),
            ),

            // "View Detailed Analysis" Button
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/detailedanalysis', arguments: {
                  'username': username,
                  'testId': testId,
                  'answers': userResponses,
                });
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 5,
              ),
              child: const Text('View Detailed Analysis'),
            ),
            
            const SizedBox(height: 10),

            // Button to return to the main menu
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/main', arguments: username);
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 5,
              ),
              child: const Text('Return to Main Menu'),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build a result widget
  Widget _buildResultWidget(BuildContext context, String question, String status, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        title: Text(
          question,
          style: const TextStyle(fontSize: 16),
        ),
        trailing: Text(
          status,
          style: TextStyle(
            fontSize: 16,
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
