import 'package:flutter/material.dart';

class BMIScreen extends StatefulWidget {
  @override
  _BMIScreenState createState() => _BMIScreenState();
}

class _BMIScreenState extends State<BMIScreen> {
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();

  double _result;
  bool _hasBeenPressed = false;
  bool _hasBeenPressed1 = false;

  String _message = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'BMI Calculator',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 70,
                      width: 100,
                      child: RaisedButton(
                        padding: new EdgeInsets.all(30),
                        child: new Text('Man  '),
                        textColor: Colors.white,
                        // 2
                        color: _hasBeenPressed1 ? Colors.grey[400] : Colors.blue,
                        // 3
                        onPressed: () => {
                          setState(() {
                            _hasBeenPressed1 = !_hasBeenPressed1;
                            this.setState(() {
                              _heightController.clear();
                              _weightController.clear(); //Clear value
                            });
                          })
                        },
                      ),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Container(
                      height: 70,
                      width: 100,
                      child: RaisedButton(
                        padding: new EdgeInsets.all(30),
                        child: new Text('Woman'),
                        textColor: Colors.white,
                        // 2
                        color: _hasBeenPressed ? Colors.blue : Colors.pink[400],
                        // 3
                        onPressed: () => {
                          setState(() {
                            _hasBeenPressed = !_hasBeenPressed;
                            _heightController.clear();
                            _weightController.clear();
                          })
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            TextField(
              controller: _heightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Height(cm)',
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _weightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Weight(kg)',
              ),
            ),
            SizedBox(height: 25),
            Container(
              height: 50,
              width: 400,
              child: RaisedButton(
                color: Colors.blue,
                child: Text(
                  "Calculate",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: calculateBMI,
              ),
            ),
            SizedBox(height: 25),
            Text(
              'Your Result',
              style: TextStyle(fontSize: 25),
            ),
            SizedBox(height: 25),
            Text(
              _result == null ? "" : "${_result.toStringAsFixed(2)}",
              style: TextStyle(
                color: Colors.redAccent,
                fontSize: 19.4,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: Text(
                _message,
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }

  void calculateBMI() {
    double height = double.parse(_heightController.text) / 100;
    double weight = double.parse(_weightController.text);

    double heightSquare = height * height;
    double result = weight / heightSquare;

    _result = result;

    setState(
      () {
        // Check if the inputs are valid
        if (height == null || height <= 0 || weight == null || weight <= 0) {
          setState(() {
            _message = "";
          });
          return;
        }

        setState(() {
          _result = weight / (height * height);
          if (_result < 18.5) {
            _message = "You are underweight";
          } else if (_result < 25) {
            _message = 'You body is Normal';
          } else if (_result < 30) {
            _message = 'You are overweight';
          } else {
            _message = 'You are obese';
          }
        });
      },
    );
  }
}
