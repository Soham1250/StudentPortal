import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  final String username;  // Accept the username as a parameter

  MainScreen({required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main Dashboard'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Profile section with username displayed
            Row(
              children: [
                CircleAvatar(
                  radius: 40,  
                  backgroundColor: Colors.grey[300],
                  child: const Icon(Icons.person, size: 40, color: Colors.blue),  
                ),
                const SizedBox(width: 20),
                Text(
                  'Hello, $username',  
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 30),
            // Grid layout for the buttons
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,  
                crossAxisSpacing: 20,  
                mainAxisSpacing: 20,  
                children: [
                  _buildGridButton('Tests', Icons.assignment, context, '/testSelection', username),
                  _buildGridButton('Performance', Icons.bar_chart, context, '/performance', username),
                  _buildGridButton('Statistics', Icons.insert_chart, context, '/statistics', username),
                  _buildGridButton('Learn', Icons.school, context, '/learn', username),
                  _buildGridButton('Feedback', Icons.feedback, context, '/feedback', username),
                  _buildGridButton('Grievances', Icons.report_problem, context, '/grievances', username),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGridButton(String label, IconData icon, BuildContext context, String route, String username) {
  return ElevatedButton(
    onPressed: () {
      Navigator.pushNamed(
        context,
        route,
        arguments: {'username': username},  // Pass the username as a Map<String, String>
      );
    },
    style: ElevatedButton.styleFrom(
      padding: const EdgeInsets.all(20),  
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),  
      ),
      elevation: 5,  
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 40),  
        const SizedBox(height: 10),
        Text(
          label,
          style: const TextStyle(fontSize: 18),  
        ),
      ],
    ),
  );
}

}
