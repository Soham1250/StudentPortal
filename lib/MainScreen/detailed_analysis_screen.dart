import 'package:flutter/material.dart';

class DetailedAnalysisScreen extends StatefulWidget {
  @override
  _DetailedAnalysisScreenState createState() => _DetailedAnalysisScreenState();
}

class _DetailedAnalysisScreenState extends State<DetailedAnalysisScreen> {
  final PageController _pageController = PageController();
  int currentIndex = 0;

  // Hardcoded list of questions, timings, and solutions
  List<Map<String, dynamic>> questionAnalysis = [
    {
      'question': 'What is the determinant of the matrix [[2, 3], [1, 4]]?',
      'userTime': '45s',
      'topperTime': '30s',
      'averageTime': '50s',
      'solution': 'The determinant of [[2, 3], [1, 4]] is 5.'
    },
    {
      'question': 'Which of the following is an identity matrix?',
      'userTime': '60s',
      'topperTime': '40s',
      'averageTime': '65s',
      'solution': '[[1, 0], [0, 1]] is the identity matrix.'
    },
    {
      'question': 'What is the trace of the matrix [[1, 2], [3, 4]]?',
      'userTime': '35s',
      'topperTime': '20s',
      'averageTime': '40s',
      'solution': 'The trace of the matrix is 5.'
    },
    {
      'question':
          'Matrix A is 2x3 and Matrix B is 3x2. What is the size of the resulting matrix when A is multiplied by B?',
      'userTime': '50s',
      'topperTime': '25s',
      'averageTime': '40s',
      'solution': 'The result is a 2x2 matrix.'
    },
    {
      'question': 'If A is a 3x3 matrix and det(A) = 4, what is det(2A)?',
      'userTime': '55s',
      'topperTime': '30s',
      'averageTime': '50s',
      'solution': 'The determinant of 2A is 32.'
    },
    {
      'question': 'Which of the following is a scalar matrix?',
      'userTime': '45s',
      'topperTime': '20s',
      'averageTime': '50s',
      'solution': 'The matrix [[3, 0], [0, 3]] is a scalar matrix.'
    },
    {
      'question': 'Which operation is required to invert a matrix?',
      'userTime': '40s',
      'topperTime': '15s',
      'averageTime': '35s',
      'solution': 'The adjugate of the matrix is used to find its inverse.'
    },
    {
      'question': 'What is the inverse of the matrix [[1, 0], [0, 1]]?',
      'userTime': '30s',
      'topperTime': '20s',
      'averageTime': '45s',
      'solution': 'The inverse is [[1, 0], [0, 1]] itself.'
    },
    {
      'question': 'Which matrix is a diagonal matrix?',
      'userTime': '35s',
      'topperTime': '25s',
      'averageTime': '40s',
      'solution': 'The matrix [[2, 0], [0, 3]] is a diagonal matrix.'
    },
    {
      'question': 'What is the rank of a 3x3 identity matrix?',
      'userTime': '20s',
      'topperTime': '15s',
      'averageTime': '35s',
      'solution': 'The rank of the 3x3 identity matrix is 3.'
    },
  ];

  // Navigate to the next page
  void nextPage() {
    if (currentIndex < questionAnalysis.length - 1) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  // Navigate to the previous page
  void previousPage() {
    if (currentIndex > 0) {
      _pageController.previousPage(
        duration: Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final String username = args['username']??'Unknown';
    final String testId = args['testId']??'Unknown';

    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Welcome $username, \n Here is your Detailed Analysis - $testId'),
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemCount: questionAnalysis.length,
              itemBuilder: (context, index) {
                final analysis = questionAnalysis[index];
                
                // Ensure null values are handled by showing "Not available"
                final userTime = analysis['userTime'] ?? 'Time not available';
                final topperTime = analysis['topperTime'] ?? 'Time not available';
                final averageTime = analysis['averageTime'] ?? 'Time not available';
                final solution = analysis['solution'] ?? 'Solution not available';

                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Question ${index + 1}: ${analysis['question']}',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 20),
                          Text('Your Time: $userTime'),
                          Text('Topper\'s Time: $topperTime'),
                          Text('Average Time: $averageTime'),
                          const SizedBox(height: 20),
                          Text(
                            'Solution:',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(solution),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Navigation buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: currentIndex > 0 ? previousPage : null,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 20),
                  ),
                  child: const Text('< Back'),
                ),
                ElevatedButton(
                  onPressed: currentIndex < questionAnalysis.length - 1
                      ? nextPage
                      : null,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 20),
                  ),
                  child: const Text('Next >'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
