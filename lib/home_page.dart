import 'package:flutter/material.dart';
import 'testpage.dart';

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen[50],
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 140.0, left: 16.0, right: 16.0),
              child: Text(
                'The World’s #1 Online Color Blind and Low Vision Test',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 80.0),
            child: Text(
              'This eye test consists of 10 photos, with 5 photos for color blindness and 5 photos for low vision. You need to correctly identify at least 3 photos in each section to be in a good situation.',
              style: TextStyle(
                fontSize: 17,
                color: Colors.black,
                height: 1.5,
                letterSpacing: 1.2,
                fontWeight: FontWeight.w300,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 70.0), // Adjust this padding as needed
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TestPage(
                      isTest: true,
                      photoIndex: 0,
                      responses: [],
                      colorBlindnessCounter: 0, // Initialize counter
                      lowVisionCounter: 0, // Initialize counter
                    ),
                  ),
                );
              },
              child: Text(
                'Take The Test',
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
          Spacer(), // Keeps remaining space after the button
        ],
      ),
    );
  }
}
