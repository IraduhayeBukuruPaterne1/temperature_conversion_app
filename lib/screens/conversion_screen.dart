import 'package:flutter/material.dart';

class TemperatureConversionScreen extends StatefulWidget {
  @override
  _TemperatureConversionScreenState createState() =>
      _TemperatureConversionScreenState();
}

class _TemperatureConversionScreenState
    extends State<TemperatureConversionScreen> {
  final TextEditingController _controller = TextEditingController();
  String _conversionType = 'F to C';
  String _result = '';
  List<String> _history = [];

  void _convert() {
    double input = double.tryParse(_controller.text) ?? 0.0;
    double output;
    if (_conversionType == 'F to C') {
      output = (input - 32) * 5 / 9;
      _result = '${output.toStringAsFixed(2)} °C';
    } else {
      output = (input * 9 / 5) + 32;
      _result = '${output.toStringAsFixed(2)} °F';
    }
    _history.add('$_conversionType: ${input.toStringAsFixed(2)} => ${_result}');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Temperature Conversion'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter temperature',
              ),
            ),
            SizedBox(height: 20),
            DropdownButton<String>(
              value: _conversionType,
              onChanged: (String? newValue) {
                setState(() {
                  _conversionType = newValue!;
                });
              },
              items: <String>['F to C', 'C to F']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _convert,
              child: Text('Convert'),
            ),
            SizedBox(height: 20),
            Text(
              _result,
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _history.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_history[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
