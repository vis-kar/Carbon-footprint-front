import 'package:carbon_footprint/data_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ResultsPage extends StatelessWidget {
  final DataHandler dataHandler;
  const ResultsPage({super.key, required this.dataHandler});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Results'),
        backgroundColor: Colors.amber.shade100,
      ),
      body: Center(
        child: FutureBuilder<Map<String, dynamic>>(
          future: dataHandler.fetchData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Show loading indicator while waiting
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return const Text('Error calculating your carbon footprint');
            } else {
              // Display the built content
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Your Carbon Footprint is',
                    style:
                        TextStyle(color: Colors.amber.shade700, fontSize: 27),
                  ),
                  const SizedBox(
                    height: 22,
                  ),
                  Container(
                    padding: EdgeInsets.all(12),
                    color: Colors.lightGreen,
                    child: Text(
                      (snapshot.data!['result'].toStringAsFixed(2)).toString(),
                      style: const TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 25,
                          
                        ),
                    ),
                  ),
                  Text(
                    'Metric tons',
                    style: TextStyle(fontSize: 20),
                  )
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
