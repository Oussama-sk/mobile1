import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class StatisticPage extends StatefulWidget {
  @override
  _StatisticPageState createState() => _StatisticPageState();
}

class _StatisticPageState extends State<StatisticPage> {
  late Future<List<UserData>> futureUserData;

  @override
  void initState() {
    super.initState();
    futureUserData = fetchUserData();
  }

  Future<List<UserData>> fetchUserData() async {
    final response = await http.get(
      Uri.parse('http://hadicsci410.atwebpages.com/statistics.php'),
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((item) => UserData.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load user data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen[50],
      appBar: AppBar(
        title: Text('Statistics'),
      ),
      body: FutureBuilder<List<UserData>>(
        future: futureUserData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data found'));
          } else {
            return Column(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0), // Adjust the padding value as needed
                    child: DataTable(
                      columnSpacing: 16.0, // Increase the spacing between columns
                      columns: [
                        DataColumn(label: Center(child: Text('Username'))),
                        DataColumn(label: Center(child: Text('Low Vision Answer'))),
                        DataColumn(label: Center(child: Text('Color Blindness Answer'))),
                      ],
                      rows: snapshot.data!
                          .map(
                            (userData) => DataRow(cells: [
                          DataCell(
                            Center(
                              child: ConstrainedBox(
                                constraints: BoxConstraints(maxWidth: 150), // Adjust the width as needed
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(userData.username, overflow: TextOverflow.ellipsis, textAlign: TextAlign.center),
                                ),
                              ),
                            ),
                          ),
                          DataCell(
                            Center(
                              child: ConstrainedBox(
                                constraints: BoxConstraints(maxWidth: 150), // Adjust the width as needed
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(userData.lowAnswer, overflow: TextOverflow.ellipsis, textAlign: TextAlign.center),
                                ),
                              ),
                            ),
                          ),
                          DataCell(
                            Center(
                              child: ConstrainedBox(
                                constraints: BoxConstraints(maxWidth: 150), // Adjust the width as needed
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(userData.colorAnswer, overflow: TextOverflow.ellipsis, textAlign: TextAlign.center),
                                ),
                              ),
                            ),
                          ),
                        ]),
                      )
                          .toList(),
                    ),
                  ),
                ),
                SizedBox(height: 20), // Add some space between the table and the button
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Back'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 50.0),
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

class UserData {
  final String username;
  final String lowAnswer;
  final String colorAnswer;

  UserData({
    required this.username,
    required this.lowAnswer,
    required this.colorAnswer,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      username: json['username'],
      lowAnswer: json['low_answer'],
      colorAnswer: json['color_answer'],
    );
  }
}
