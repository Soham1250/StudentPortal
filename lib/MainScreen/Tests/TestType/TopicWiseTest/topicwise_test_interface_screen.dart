import 'package:flutter/material.dart';

class TestInterfaceScreen extends StatefulWidget {
  @override
  _TestInterfaceScreenState createState() => _TestInterfaceScreenState();
}

class _TestInterfaceScreenState extends State<TestInterfaceScreen> {
  // List of questions, answers, and whether the question is marked for review
  List<Map<String, dynamic>> questions = [
    {
      'question': 'What is the determinant of the matrix [[2, 3], [1, 4]]?',
      'options': ['5', '7', '8', '6'],
      'correctAnswer': '5',
      'userAnswer': null,
      'markedForReview': false,
    },
    {
      'question': 'Which of the following is an identity matrix?',
      'options': [
        '[[1, 0], [0, 1]]',
        '[[2, 0], [0, 2]]',
        '[[0, 1], [1, 0]]',
        '[[1, 1], [1, 1]]'
      ],
      'correctAnswer': '[[1, 0], [0, 1]]',
      'userAnswer': null,
      'markedForReview': false,
    },
    {
      'question': 'What is the trace of the matrix [[1, 2], [3, 4]]?',
      'options': ['5', '4', '7', '6'],
      'correctAnswer': '5',
      'userAnswer': null,
      'markedForReview': false,
    },
    {
      'question': 'Matrix A is 2x3 and Matrix B is 3x2. What is the size of the resulting matrix when A is multiplied by B?',
      'options': ['2x2', '2x3', '3x3', '3x2'],
      'correctAnswer': '2x2',
      'userAnswer': null,
      'markedForReview': false,
    },
    {
      'question': 'If A is a 3x3 matrix and det(A) = 4, what is det(2A)?',
      'options': ['32', '16', '8', '64'],
      'correctAnswer': '32',
      'userAnswer': null,
      'markedForReview': false,
    },
    {
      'question': 'Which of the following is a scalar matrix?',
      'options': [
        '[[3, 0], [0, 3]]',
        '[[2, 1], [1, 2]]',
        '[[1, 2], [2, 1]]',
        '[[4, 0], [0, 2]]'
      ],
      'correctAnswer': '[[3, 0], [0, 3]]',
      'userAnswer': null,
      'markedForReview': false,
    },
    {
      'question': 'Which operation is required to invert a matrix?',
      'options': [
        'Multiplication by identity',
        'Matrix multiplication',
        'Matrix determinant',
        'Matrix adjugate'
      ],
      'correctAnswer': 'Matrix adjugate',
      'userAnswer': null,
      'markedForReview': false,
    },
    {
      'question': 'What is the inverse of the matrix [[1, 0], [0, 1]]?',
      'options': [
        '[[1, 0], [0, 1]]',
        '[[0, 1], [1, 0]]',
        '[[1, 1], [1, 1]]',
        'No inverse exists'
      ],
      'correctAnswer': '[[1, 0], [0, 1]]',
      'userAnswer': null,
      'markedForReview': false,
    },
    {
      'question': 'Which matrix is a diagonal matrix?',
      'options': [
        '[[2, 0], [0, 3]]',
        '[[1, 1], [1, 1]]',
        '[[0, 0], [0, 0]]',
        '[[2, 3], [3, 2]]'
      ],
      'correctAnswer': '[[2, 0], [0, 3]]',
      'userAnswer': null,
      'markedForReview': false,
    },
    {
      'question': 'What is the rank of a 3x3 identity matrix?',
      'options': ['3', '1', '0', '2'],
      'correctAnswer': '3',
      'userAnswer': null,
      'markedForReview': false,
    },
  ];

  int currentQuestionIndex = 0;

  // Collect the selected answers
  List<String?> selectedAnswers = [];

  @override
  void initState() {
    super.initState();
    selectedAnswers = List<String?>.filled(questions.length, null);
  }

  // Move to the next question
  void nextQuestion() {
    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
      });
    }
  }

  // Move to the previous question
  void previousQuestion() {
    if (currentQuestionIndex > 0) {
      setState(() {
        currentQuestionIndex--;
      });
    }
  }

  // Mark or unmark the current question for review
  void toggleMarkForReview() {
    setState(() {
      questions[currentQuestionIndex]['markedForReview'] =
          !questions[currentQuestionIndex]['markedForReview'];
    });
  }

  // Save the user's selected answer for the current question
  void answerQuestion(String selectedAnswer) {
    setState(() {
      questions[currentQuestionIndex]['userAnswer'] = selectedAnswer;
      selectedAnswers[currentQuestionIndex] = selectedAnswer;
    });
  }

  // Submit the test
  void submitTest(BuildContext context, String username, String testId) {
    // Navigate to the test analysis screen with parameters
    Navigator.pushNamed(
      context,
      '/testanalysis',
      arguments: {
        'username': username,
        'testId': testId,
        'answers': selectedAnswers, // Pass the list of selected answers
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, String>?;
    final String username = args?["username"] ?? "Unknown";
    final String testId = args?["testId"] ?? "Unknown";

    final currentQuestion = questions[currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text('Question ${currentQuestionIndex + 1} of ${questions.length}'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Answered: ${selectedAnswers.where((ans) => ans != null).length} / ${questions.length}',
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Display the question
            Text(
              currentQuestion['question'],
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Display the options as buttons
            ...currentQuestion['options'].map<Widget>((option) {
              return ElevatedButton(
                onPressed: () => answerQuestion(option),
                style: ElevatedButton.styleFrom(
                  backgroundColor: currentQuestion['userAnswer'] == option
                      ? Colors.green
                      : null,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Text(
                  option,
                  style: const TextStyle(fontSize: 18),
                ),
              );
            }).toList(),
            const SizedBox(height: 30),

            // Navigation and Mark for Review buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: previousQuestion,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                  ),
                  child: const Text('< Back'),
                ),
                ElevatedButton(
                  onPressed: toggleMarkForReview,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                  ),
                  child: Text(currentQuestion['markedForReview']
                      ? 'Unmark'
                      : 'Mark for Review'),
                ),
                ElevatedButton(
                  onPressed: currentQuestionIndex == questions.length - 1
                      ? () => submitTest(context, username, testId)
                      : nextQuestion,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                  ),
                  child: Text(currentQuestionIndex == questions.length - 1
                      ? 'Submit'
                      : 'Next >'),
                ),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
