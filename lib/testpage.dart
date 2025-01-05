import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'resultpage.dart';

class TestPage extends StatefulWidget {
  final bool isTest;
  final int photoIndex;
  final List<int> responses;
  final int colorBlindnessCounter;
  final int lowVisionCounter;
  final String username;

  TestPage({
    required this.isTest,
    required this.photoIndex,
    required this.responses,
    required this.colorBlindnessCounter,
    required this.lowVisionCounter,
    required this.username,
  });

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  final List<String> colorBlindnessPhotos = [
    'assets/page1.png',
    'assets/page2.png',
    'assets/page3.png',
    'assets/page4.png',
    'assets/page5.png',
  ];

  final List<int> colorBlindnessAnswers = [1, 4, 3, 5, 2];

  final List<String> lowVisionPhotos = [
    'assets/p1.png',
    'assets/p2.png',
    'assets/p3.png',
    'assets/p4.png',
    'assets/p5.png',
  ];

  final List<int> lowVisionAnswers = [1, 6, 2, 3, 5];

  String getCurrentDate() {
    return DateFormat('yyyy-MM-dd').format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    List<String> photos = widget.isTest ? colorBlindnessPhotos : lowVisionPhotos;
    double imgWidth = widget.isTest ? 280 : 25;
    double imgHeight = widget.isTest ? 280 : 25;

    return Scaffold(
      backgroundColor: Colors.lightGreen[50],
      appBar: AppBar(
        title: Text(widget.isTest ? 'Color Blindness Test' : 'Low Vision Test'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                getCurrentDate(),
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.topRight,
              child: Text(
                'Welcome, ${widget.username}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(height: widget.isTest ? 50 : 150),
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
                  crossAxisCount: 3,
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: generateOptions(widget.isTest),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, bottom: 40.0),
                  child: Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        backgroundColor: Colors.white60,
                        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 80.0),
                      ),
                      onPressed: () => handleOptionSelection(0),
                      child: Text(
                        'Nothing',
                        style: TextStyle(fontSize: 30),
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

  List<Widget> generateOptions(bool isTest) {
    return List.generate(6, (index) {
      String text = isTest
          ? (index + 1).toString()
          : String.fromCharCode(65 + index);
      return buildOptionButton(text, isTest ? index + 1 : 65 + index - 64);
    });
  }

  Widget buildOptionButton(String text, int value) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          backgroundColor: Colors.white60,
          padding: const EdgeInsets.symmetric(vertical: 12.0),
        ),
        onPressed: () => handleOptionSelection(value),
        child: Text(
          text,
          style: TextStyle(fontSize: 30),
        ),
      ),
    );
  }

  void handleOptionSelection(int option) {
    List<int> updatedResponses = List.from(widget.responses);
    updatedResponses.add(option);
    int newColorBlindnessCounter = widget.colorBlindnessCounter;
    int newLowVisionCounter = widget.lowVisionCounter;
    List<int> correctAnswers = widget.isTest ? colorBlindnessAnswers : lowVisionAnswers;
    if (option == correctAnswers[widget.photoIndex]) {
      if (widget.isTest) {
        newColorBlindnessCounter++;
      } else {
        newLowVisionCounter++;
      }
    }

    bool isLastPhoto = widget.photoIndex == (widget.isTest ? colorBlindnessPhotos : lowVisionPhotos).length - 1;
    if (isLastPhoto) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => widget.isTest
              ? TestPage(
            isTest: false,
            photoIndex: 0,
            responses: updatedResponses,
            colorBlindnessCounter: newColorBlindnessCounter,
            lowVisionCounter: newLowVisionCounter,
            username: widget.username,
          )
              : ResultPage(
            colorBlindnessCounter: newColorBlindnessCounter,
            lowVisionCounter: newLowVisionCounter,
            username: widget.username,
          ),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TestPage(
            isTest: widget.isTest,
            photoIndex: widget.photoIndex + 1,
            responses: updatedResponses,
            colorBlindnessCounter: newColorBlindnessCounter,
            lowVisionCounter: newLowVisionCounter,
            username: widget.username,
          ),
        ),
      );
    }
  }
}
