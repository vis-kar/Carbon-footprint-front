import 'package:carbon_footprint/data_handler.dart';
import 'package:flutter/material.dart';
import './results_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Future<void> sendData() {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData.light(),
        debugShowCheckedModeBanner: false,
        home: const HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _transportcontroller = TextEditingController();

  final TextEditingController _electricitycontroller = TextEditingController();

  final TextEditingController _wastecontroller = TextEditingController();

  final TextEditingController _dietcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    void releaseKeyboard(event) {
      FocusManager.instance.primaryFocus?.unfocus();
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber.shade100,
        title: const Text('Carbon Footprint Calculator'),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.menu))],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              keyboardType: TextInputType.number,
              onTapOutside: releaseKeyboard,
              controller: _transportcontroller,
              decoration:
                  const InputDecoration(hintText: "Daily commute distance (in km)"),
            ),
            const SizedBox(
              height: 30,
            ),
            TextField(
              keyboardType: TextInputType.number,
              onTapOutside: releaseKeyboard,
              controller: _electricitycontroller,
              decoration: const InputDecoration(
                  hintText: "Monthly electricity consumption (in kWh)"),
            ),
            const SizedBox(
              height: 30,
            ),
            TextField(
              keyboardType: TextInputType.number,
              onTapOutside: releaseKeyboard,
              controller: _wastecontroller,
              decoration:
                  const InputDecoration(hintText: "Waste generated per week (in kg)"),
            ),
            const SizedBox(
              height: 30,
            ),
            TextField(
              keyboardType: TextInputType.number,
              onTapOutside: releaseKeyboard,
              controller: _dietcontroller,
              decoration: const InputDecoration(hintText: "Number of meals per day"),
            ),
            const SizedBox(
              height: 40,
            ),
            ElevatedButton(
                onPressed: () {
                  if (_transportcontroller.text == '' ||
                      _dietcontroller.text == '' ||
                      _electricitycontroller.text == '' ||
                      _wastecontroller.text == '') {
                    const snackBar = SnackBar(
                        content: Row(
                      children: [
                        Icon(Icons.warning),
                        Text('Missing Required Fields, please fill all fields')
                      ],
                    ));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  } else {
                    final dataHandler = DataHandler(
                        transport: double.parse(_transportcontroller.text),
                        electricity: double.parse(_electricitycontroller.text),
                        meals: double.parse(_dietcontroller.text),
                        waste: double.parse(_wastecontroller.text));
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            ResultsPage(dataHandler: dataHandler)));
                  }
                },
                child: const Text("Submit"))
          ],
        ),
      ),
    );
  }
}
