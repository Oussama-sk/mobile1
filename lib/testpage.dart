import 'package:flutter/material.dart';
import 'resultpage.dart';

class TestPage extends StatefulWidget {
  final bool isTest; // Indicates if the current test is for color blindness
  final int photoIndex; // Index of the current photo being displayed
  final List<int> responses; // List of user responses
  final int colorBlindnessCounter; // Counter for correct color blindness answers
  final int lowVisionCounter; // Counter for correct low vision answers

  TestPage({
    required this.isTest,
    required this.photoIndex,
    required this.responses,
    required this.colorBlindnessCounter,
    required this.lowVisionCounter,
  });

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  // List of color blindness test photos
  final List<String> colorBlindnessPhotos = [
    'assets/page1.png',
    'assets/page2.png',
    'assets/page3.png',
    'assets/page4.png',
    'assets/page5.png',
  ];

  // Correct answers for color blindness photos
  final List<int> colorBlindnessAnswers = [1, 4, 3, 5, 2];

  // List of low vision test photos
  final List<String> lowVisionPhotos = [
    'assets/p1.png',
    'assets/p2.png',
    'assets/p3.png',
    'assets/p4.png',
    'assets/p5.png',
  ];

  // Correct answers for low vision photos
  final List<int> lowVisionAnswers = [1, 6, 2, 3, 5];

  @override
  Widget build(BuildContext context) {
    // Select the appropriate photo list based on the test type
    List<String> photos = widget.isTest ? colorBlindnessPhotos : lowVisionPhotos;
    double imgWidth = widget.isTest ? 280 : 25;
    double imgHeight = widget.isTest ? 280 : 25;

    return Scaffold(
      backgroundColor: Colors.lightGreen[50],
      appBar: AppBar(
        title: Text(widget.isTest ? 'Color Blindness Test' : 'Low Vision Test'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(height: widget.isTest ? 50 : 150), // Space above the image, more for low vision test
          Center(
            child: Image.asset(
              photos[widget.photoIndex],
              width: imgWidth,
              height: imgHeight,
              fit: BoxFit.contain,
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GridView.count(
                  crossAxisCount: 3, // number of column
                  shrinkWrap: true, // They only take up the space their children need ( 3 column )
                  padding: const EdgeInsets.symmetric(horizontal: 20), // space between 3 col and left,right
                  children: generateOptions(widget.isTest), // Generate option buttons
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, bottom: 40.0), //External padding for "Nothing" option
                  child: Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        backgroundColor: Colors.white60, // Option button background color
                        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 80.0), // Internal padding
                      ),
                      onPressed: () => handleOptionSelection(0), // "Nothing" option
                      child: Text(
                        'Nothing',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Generate the option buttons based on the test type
  List<Widget> generateOptions(bool isTest) {
    return List.generate(6, (index) { // index start with value 0
      // Set the button text to numbers for color blindness or letters for low vision
      String text = isTest
          ? (index + 1).toString()
          : String.fromCharCode(65 + index);
      return buildOptionButton(text, isTest ? index + 1 : 65 + index - 64);
    });
  }

  // Build each option button
  Widget buildOptionButton(String text, int value) {
    return Padding(
      padding: const EdgeInsets.all(4.0), // external for all sides of the widget
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          backgroundColor: Colors.white60, // Option button background color
          padding: const EdgeInsets.symmetric(vertical: 12.0), // Internal padding
        ),
        onPressed: () => handleOptionSelection(value), // Handle button press
        child: Text(
          text,
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }

  // Handle the selection of an option
  void handleOptionSelection(int option) {
    // Create a new list of responses including the selected option
    List<int> updatedResponses = List.from(widget.responses);
    updatedResponses.add(option);

    int newColorBlindnessCounter = widget.colorBlindnessCounter;
    int newLowVisionCounter = widget.lowVisionCounter;

    // Determine the correct answers for the current test
    List<int> correctAnswers = widget.isTest ? colorBlindnessAnswers : lowVisionAnswers;

    // Increment the respective counter if the option number matches the correct answer
    if (option == correctAnswers[widget.photoIndex]) {
      if (widget.isTest) {
        newColorBlindnessCounter++;
      } else {
        newLowVisionCounter++;
      }
    }

    // Check if the current photo is the last one in the test
    bool isLastPhoto = widget.photoIndex == (widget.isTest ? colorBlindnessPhotos : lowVisionPhotos).length - 1;

    if (isLastPhoto) {
      // If last photo, navigate to the next test or the results page
      Navigator.push( // to a new page
        context,
        MaterialPageRoute(  //creates a route that uses a material design page transition
          builder: (context) => widget.isTest
              ? TestPage(
            isTest: false,
            photoIndex: 0,
            responses: updatedResponses,
            colorBlindnessCounter: newColorBlindnessCounter,
            lowVisionCounter: newLowVisionCounter,
          )
              : ResultPage(
            colorBlindnessCounter: newColorBlindnessCounter,
            lowVisionCounter: newLowVisionCounter,
          ),
        ),
      );
    } else {
      // Otherwise, navigate to the next photo
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TestPage(
            isTest: widget.isTest,
            photoIndex: widget.photoIndex + 1,
            responses: updatedResponses,
            colorBlindnessCounter: newColorBlindnessCounter,
            lowVisionCounter: newLowVisionCounter,
          ),
        ),
      );
    }
  }
}
