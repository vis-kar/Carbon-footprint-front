import 'package:http/http.dart' as http;
import 'dart:convert';

class DataHandler {
  final double transport, electricity, meals, waste;
  DataHandler(
      {required this.transport,
      required this.electricity,
      required this.meals,
      required this.waste});

  Future<Map<String, dynamic>> fetchData() async {
    final response = await http.post(
        Uri.parse('https://nusvr-carbon-emissions.onrender.com/predict'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'transport': transport,
          'electricity': electricity,
          'meals': meals,
          'waste': waste
        }));
    final data = jsonDecode(response.body) as Map<String, dynamic>;
    return data;
  }
}
