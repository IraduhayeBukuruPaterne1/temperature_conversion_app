import 'package:flutter/material.dart';

void main() {
  runApp(TemperatureConverterApp());
}

class TemperatureConverterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Temperature Converter',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        textTheme: TextTheme(
          bodyLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.teal, // Button background color
            foregroundColor: Colors.white, // Button text color
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
          ),
        ),
      ),
      home: TemperatureConverterScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class TemperatureConverterScreen extends StatefulWidget {
  @override
  _TemperatureConverterScreenState createState() =>
      _TemperatureConverterScreenState();
}

class _TemperatureConverterScreenState
    extends State<TemperatureConverterScreen> {
  final TextEditingController _controller = TextEditingController();
  String _conversionType = 'CtoF';
  String _result = '';
  List<String> _history = [];

  void _convertTemperature() {
    double inputTemp = double.tryParse(_controller.text) ?? 0.0;
    double convertedTemp;

    if (_conversionType == 'CtoF') {
      convertedTemp = inputTemp * 9 / 5 + 32;
      _result =
          '${inputTemp.toStringAsFixed(2)} °C => ${convertedTemp.toStringAsFixed(2)} °F';
    } else {
      convertedTemp = (inputTemp - 32) * 5 / 9;
      _result =
          '${inputTemp.toStringAsFixed(2)} °F => ${convertedTemp.toStringAsFixed(2)} °C';
    }

    setState(() {
      _history.add(_result);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Temperature Converter'),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min, // Shrink to fit content
                children: [
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          TextField(
                            controller: _controller,
                            decoration: InputDecoration(
                              labelText: 'Enter Temperature',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              filled: true,
                              fillColor: Colors.grey[200],
                            ),
                            keyboardType: TextInputType.number,
                          ),
                          SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: RadioListTile(
                                  title: Text('Celsius to Fahrenheit'),
                                  value: 'CtoF',
                                  groupValue: _conversionType,
                                  onChanged: (value) {
                                    setState(() {
                                      _conversionType = value.toString();
                                    });
                                  },
                                ),
                              ),
                              Expanded(
                                child: RadioListTile(
                                  title: Text('Fahrenheit to Celsius'),
                                  value: 'FtoC',
                                  groupValue: _conversionType,
                                  onChanged: (value) {
                                    setState(() {
                                      _conversionType = value.toString();
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          Center(
                            child: ElevatedButton(
                              onPressed: _convertTemperature,
                              child: Text('Convert'),
                            ),
                          ),
                          SizedBox(height: 16),
                          if (_result.isNotEmpty)
                            Text(
                              _result,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.teal[700],
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  // Flexible instead of Expanded
                  Flexible(
                    fit: FlexFit.loose, // This allows flexibility in height
                    child: Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisSize:
                              MainAxisSize.min, // Ensure it wraps content
                          children: [
                            Text(
                              'Conversion History',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            Divider(
                              color: Colors.teal,
                              thickness: 1,
                            ),
                            // Flexible to prevent overflow in height
                            Flexible(
                              fit: FlexFit.loose, // Prevent overflow
                              child: ListView.builder(
                                shrinkWrap:
                                    true, // Ensure it doesn't expand indefinitely
                                itemCount: _history.length,
                                itemBuilder: (context, index) {
                                  return Card(
                                    margin: EdgeInsets.symmetric(vertical: 5),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    color: Colors.teal[50],
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Text(
                                        _history[index],
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
