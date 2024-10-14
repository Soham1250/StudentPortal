import 'dart:async'; // For the timer
import 'package:flutter/material.dart';

class FltTestInterfaceScreen extends StatefulWidget {
  @override
  _FltTestInterfaceScreen createState() => _FltTestInterfaceScreen();
}

class _FltTestInterfaceScreen extends State<FltTestInterfaceScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
      'question':
          'Matrix A is 2x3 and Matrix B is 3x2. What is the size of the resulting matrix when A is multiplied by B?',
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
  List<String?> selectedAnswers = [];

  Timer? _timer;
  int _remainingTime = 20 * 60; // 20 minutes in seconds

  @override
  void initState() {
    super.initState();
    selectedAnswers = List<String?>.filled(questions.length, null);
    startTimer();
  }

  // Timer logic
  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        setState(() {
          _remainingTime--;
        });
      } else {
        timer.cancel();
        submitTest(context, 'username', 'testId'); // Auto-submit test
      }
    });
  }

  // Convert remaining time to a formatted string (mm:ss)
  String getFormattedTime() {
    int minutes = _remainingTime ~/ 60;
    int seconds = _remainingTime % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  void nextQuestion() {
    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
      });
    }
  }

  void previousQuestion() {
    if (currentQuestionIndex > 0) {
      setState(() {
        currentQuestionIndex--;
      });
    }
  }

  void toggleMarkForReview() {
    setState(() {
      questions[currentQuestionIndex]['markedForReview'] =
          !questions[currentQuestionIndex]['markedForReview'];
    });
  }

  void answerQuestion(String selectedAnswer) {
    setState(() {
      questions[currentQuestionIndex]['userAnswer'] = selectedAnswer;
      selectedAnswers[currentQuestionIndex] = selectedAnswer;
    });
  }

  void submitTest(BuildContext context, String username, String testId) {
    _timer?.cancel();
    Navigator.pushNamed(
      context,
      '/testanalysis',
      arguments: {
        'username': username,
        'testId': testId,
        'answers': selectedAnswers,
      },
    );
  }

  // Helper to return color based on question status
  Color getQuestionStatusColor(int index) {
    final question = questions[index];
    if (question['userAnswer'] != null && question['markedForReview']) {
      return Colors.purple; // Answered & Marked for Review
    } else if (question['userAnswer'] != null) {
      return Colors.green; // Answered
    } else if (question['markedForReview']) {
      return Colors.blue; // Marked for Review
    } else {
      return Colors.red; // Unanswered
    }
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, String>?;
    final String username = args?["username"] ?? "Unknown";
    final String testId = args?["testId"] ?? "Unknown";

    final currentQuestion = questions[currentQuestionIndex];

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(testId),
            Text(getFormattedTime()), // Show the countdown timer
          ],
        ),
      ),
      endDrawer: Drawer(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text('Questions Overview',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5),
                  itemCount: questions.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          currentQuestionIndex = index;
                          Navigator.pop(context); // Close the drawer
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.all(4.0),
                        color: getQuestionStatusColor(
                            index), // Color based on question status
                        child: Center(
                          child: Text('${index + 1}'),
                        ),
                      ),
                    );
                  },
                ),
              ),
              // Legend
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _legendItem(Colors.green, "Answered"),
                        _legendItem(Colors.red, "Unanswered"),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _legendItem(Colors.purple, "Answered & Marked"),
                        _legendItem(Colors.blue, "Marked for Review"),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Display the question
            Expanded(
              flex: 3,
              child: Center(
                child: Text(
                  currentQuestion['question'],
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            // Display the options as buttons
            Expanded(
              flex: 5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildOptionButton(currentQuestion['options'][0]),
                      _buildOptionButton(currentQuestion['options'][1]),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildOptionButton(currentQuestion['options'][2]),
                      _buildOptionButton(currentQuestion['options'][3]),
                    ],
                  ),
                ],
              ),
            ),

            // Navigation and Mark for Review buttons
            Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: previousQuestion,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 25),
                    ),
                    child: const Text('< Back'),
                  ),
                  ElevatedButton(
                    onPressed: toggleMarkForReview,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 25),
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
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 25),
                    ),
                    child: Text(currentQuestionIndex == questions.length - 1
                        ? 'Submit'
                        : 'Next >'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionButton(String option) {
    final currentQuestion = questions[currentQuestionIndex];
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.4, // Width 40% of the screen
      child: ElevatedButton(
        onPressed: () => answerQuestion(option),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 20),
          backgroundColor:
              currentQuestion['userAnswer'] == option ? Colors.green : null,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          option,
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }

  Widget _legendItem(Color color, String text) {
    return Row(
      children: [
        Container(
          width: 15,
          height: 15,
          color: color,
        ),
        const SizedBox(width: 5),
        Text(text),
      ],
    );
  }
}
