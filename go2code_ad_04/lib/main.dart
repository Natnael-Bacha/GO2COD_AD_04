import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TestApp(),
    );
  }
}

class TestApp extends StatefulWidget {
  @override
  _TestAppState createState() => _TestAppState();
}

class _TestAppState extends State<TestApp> {
  late double _userInput;
  String _convertedMeasure = 'Meters'; // Initialize with a default value
  String errorMessage = '';
  String _startValue = 'Meters'; // Initialize with a default value
  var fromUnits = [
    'Meters',
    'Kilometer',
    'Grams',
    'Kilograms (kg)',
    'Feet',
    'Miles',
    'Pounds (lbs)',
    'Ounces'
  ];

  final Map<String, int> measuresMap = {
    'Meters': 0,
    'Kilometer': 1,
    'Grams': 2,
    'Kilograms (kg)': 3,
    'Feet': 4,
    'Miles': 5,
    'Pounds (lbs)': 6,
    'Ounces': 7
  };

  dynamic formulas = {
    '0': [1, 0.001, 0, 0, 3.28084, 0.000621371, 0, 0],
    '1': [1000, 1, 0, 0, 3280.84, 0.621371, 0, 0],
    '2': [0, 0, 1, 0.001, 0, 0, 0.00220462, 0.035274],
    '3': [0, 0, 1000, 1, 0, 0, 2.20462, 35.274],
    '4': [0.3048, 0.0003048, 0, 0, 1, 0.000189394, 0, 0],
    '5': [1609.34, 1.60934, 0, 0, 5280, 1, 0, 0],
    '6': [0, 0, 453.592, 0.453592, 0, 0, 1, 16],
    '7': [0, 0, 28.3495, 0.0283495, 3.28084, 0, 0.0625, 1]
  };

  void converter(double value, String from, String to) {
    int? nFrom = measuresMap[from];
    int? nTo = measuresMap[to];
    var multiplier = formulas[nFrom.toString()][nTo];
    var result = value * multiplier;

    if (result == 0) {
      errorMessage = 'Cannot perform this conversion';
    } else {
      errorMessage =
          '${_userInput.toString()} $_startValue are ${result.toString()} $_convertedMeasure';
    }
    setState(() {
      errorMessage = errorMessage;
    });
  }

  @override
  void initState() {
    _userInput = 0;
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Column(
              children: [
             
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(
                        color: Colors.black,
                        width: 2
                        
                      )
                    ),
                    child: TextField(
                      style: TextStyle(fontSize: 20, color: Colors.white),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.black,
                        hintText: 'Enter Your Value',
                        hintStyle: TextStyle(color: Colors.black),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      
                      ),
                      onChanged: (text) {
                        var input = double.tryParse(text);
                        if (input != null) {
                          setState(() {
                            _userInput = input;
                          });
                        }
                      },
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'From',
                  style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  child: Container(
                    width: 130,
                    height: 130,
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.black,
                  
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        hint: Text(
                          'Choose Your Unit',
                          style: TextStyle(color: Colors.amber),
                        ),
                        dropdownColor: Colors.black,
                        isExpanded: true,
                        style: TextStyle(fontSize: 15, color: Colors.white),
                        items: fromUnits.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _startValue = value!;
                          });
                        },
                        value: _startValue,
                      ),
                    ),
                  ),
                ), 
              Icon(Icons.arrow_forward),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  child: Container(
                    width: 130,
                    height: 130,
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.black,
                    
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        hint: Text(
                          'Choose Your Unit',
                          style: TextStyle(color: Colors.black),
                        ),
                        dropdownColor: Colors.black,
                        isExpanded: true,
                        style: TextStyle(fontSize: 15, color: Colors.white),
                        items: fromUnits.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _convertedMeasure = value!;
                          });
                        },
                        value: _convertedMeasure,
                      ),
                    ),
                  ),
                ),

                  ],
                ),
                
                SizedBox(height: 20),
                Text(
                  'To',
                  style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
                ),
                
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: TextButton(
                    onPressed: () {
                      if (_startValue.isEmpty || _convertedMeasure.isEmpty || _userInput == 0) {
                        return;
                      } else {
                        converter(_userInput, _startValue, _convertedMeasure);
                      }
                    },
                    child: Material(
                      elevation: 10,
                        borderRadius: BorderRadius.circular(20),
                      child: Container(
                        alignment: AlignmentDirectional.center,
                        width: 200,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'Convert',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Material( 
                borderRadius: BorderRadius.circular(8),
                elevation: 10,
                
                  child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 2,
                      color: Colors.black
                    ),
                    borderRadius: BorderRadius.circular(8)
                  ),
                    width: 400,
                    height: 250,
                    
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Result:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)),
                          SizedBox(height: 70,),
                        Center(
                          child: Text(
                            errorMessage.isEmpty ? '' : errorMessage,
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}