import 'package:carbon_footprint/data_handler.dart';
import 'package:flutter/material.dart';

class ResultsPage extends StatelessWidget {
  final DataHandler dataHandler;
  const ResultsPage({super.key, required this.dataHandler});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Results'),
        backgroundColor: Colors.amber.shade100,
      ),
      body: Center(
        child: FutureBuilder<Map<String, dynamic>>(
          future: dataHandler.fetchData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Show loading indicator while waiting
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error calculating your carbon footprint');
            } else {
              // Display the built content
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Your Carbon Footprint in metric tons:'),
                  Text(snapshot.data!['result'].toString())
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
