import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _loginEmailController = TextEditingController();
  final TextEditingController _confirmEmailController = TextEditingController();
  String _errorMessage = ''; // To store any error messages

  // This method will handle the Send button press
  void _sendRequest() {
    final loginEmail = _loginEmailController.text.trim();
    final confirmEmail = _confirmEmailController.text.trim();

    // Check if any of the fields are empty
    if (loginEmail.isEmpty || confirmEmail.isEmpty) {
      setState(() {
        _errorMessage = 'Please fill in both fields.';
      });
    } else if (loginEmail != confirmEmail) {
      setState(() {
        _errorMessage = 'The emails do not match.';
      });
    } else {
      setState(() {
        _errorMessage = ''; // Clear error message
      });

      // Show pop-up message after hitting Send button
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Request Sent"),
            content: const Text("We've got your request, relax."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/'); // Redirect to login page
                },
                child: const Text("Back"),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'You Dummy, Got a smooth brain ?!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            const Text(
              'No worries we got you',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            // LoginID/Email TextField
            TextField(
              controller: _loginEmailController,
              decoration: const InputDecoration(
                labelText: 'Your loginID/Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            // Confirm LoginID/Email TextField
            TextField(
              controller: _confirmEmailController,
              decoration: const InputDecoration(
                labelText: 'Confirm LoginID/Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            // Display error message if fields are empty or mismatched
            if (_errorMessage.isNotEmpty)
              Text(
                _errorMessage,
                style: const TextStyle(color: Colors.red),
              ),
            const SizedBox(height: 20),

            // Back and Send Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Go back to the previous screen
                  },
                  style: ElevatedButton.styleFrom(
                    padding:
                        const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text('< Back'),
                ),
                ElevatedButton(
                  onPressed: _sendRequest, // Send button triggers the validation and pop-up
                  style: ElevatedButton.styleFrom(
                    padding:
                        const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text('Send >'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
