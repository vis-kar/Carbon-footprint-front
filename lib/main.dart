import 'package:carbon_footprint/data_handler.dart';
import 'package:flutter/material.dart';
import './results_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  // Future<void> sendData() {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData.light(),
        debugShowCheckedModeBanner: false,
        home: HomePage());
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
        title: Text('Carbon Footprint Calculator'),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.menu))],
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              keyboardType: TextInputType.number,
              onTapOutside: releaseKeyboard,
              controller: _transportcontroller,
              decoration:
                  InputDecoration(hintText: "Daily commute distance (in km)"),
            ),
            SizedBox(
              height: 30,
            ),
            TextField(
              keyboardType: TextInputType.number,
              onTapOutside: releaseKeyboard,
              controller: _electricitycontroller,
              decoration: InputDecoration(
                  hintText: "Monthly electricity consumption (in kWh)"),
            ),
            SizedBox(
              height: 30,
            ),
            TextField(
              keyboardType: TextInputType.number,
              onTapOutside: releaseKeyboard,
              controller: _wastecontroller,
              decoration:
                  InputDecoration(hintText: "Waste generated per week (in kg)"),
            ),
            SizedBox(
              height: 30,
            ),
            TextField(
              keyboardType: TextInputType.number,
              onTapOutside: releaseKeyboard,
              controller: _dietcontroller,
              decoration: InputDecoration(hintText: "Number of meals per day"),
            ),
            SizedBox(
              height: 40,
            ),
            ElevatedButton(
                onPressed: () {
                  if (_transportcontroller.text == '' ||
                      _dietcontroller.text == '' ||
                      _electricitycontroller.text == '' ||
                      _wastecontroller.text == '') {
                    final snackBar = SnackBar(
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
                child: Text("Submit"))
          ],
        ),
      ),
    );
  }
}
