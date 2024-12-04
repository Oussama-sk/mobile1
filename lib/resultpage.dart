import 'package:flutter/material.dart';
import 'home_page.dart';

class ResultPage extends StatelessWidget {
  final int colorBlindnessCounter;
  final int lowVisionCounter;

  ResultPage({
    required this.colorBlindnessCounter,
    required this.lowVisionCounter,
  });

  String getColorBlindnessAdvice() {
    if (colorBlindnessCounter < 3) {
      return "You should visit a doctor; you might have color blindness.";
    } else {
      return "You don't have color blindness.";
    }
  }

  String getLowVisionAdvice() {
    if (lowVisionCounter < 3) {
      return "You should visit a doctor; you might have low vision.";
    } else {
      return "You don't have low vision.";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[50], // Set the background color
      appBar: AppBar(
        title: Text('Test Results'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(18.0), // Add padding around the column
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start, // Align text to the start
            children: [
              Text(
                'Color Blindness Test Results: $colorBlindnessCounter',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 8), // Add some spacing between texts
              Text(
                getColorBlindnessAdvice(),
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 80), // Add more space before the next section
              Text(
                'Low Vision Test Results: $lowVisionCounter',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 8), // Add some spacing between texts
              Text(
                getLowVisionAdvice(),
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 30), // Space before the button
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyHomePage(title: 'Home Page'), // Navigate back to HomePage
                      ),
                    );
                  },
                  child: Text(
                    'Back to Home',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontFamily: 'Roboto',
                      height: 1.5,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue, // Background color of the button
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
