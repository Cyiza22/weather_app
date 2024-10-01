import 'package:flutter/material.dart';


void main() => runApp(TemperatureConverterApp());


class TemperatureConverterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Temperature Converter',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: TemperatureConverterHome(),
    );
  }
}


class TemperatureConverterHome extends StatefulWidget {
  @override
  _TemperatureConverterHomeState createState() => _TemperatureConverterHomeState();
}


class _TemperatureConverterHomeState extends State<TemperatureConverterHome> {
  bool isFahrenheitToCelsius = true;
  TextEditingController _temperatureController = TextEditingController();
  String _convertedTemperature = '';
  List<String> _conversionHistory = [];


  void _convertTemperature() {
    double inputTemp = double.tryParse(_temperatureController.text) ?? 0;
    double convertedTemp;
    String result;


    if (isFahrenheitToCelsius) {
      convertedTemp = (inputTemp - 32) * 5 / 9;
      result = 'F to C: ${inputTemp.toStringAsFixed(1)} => ${convertedTemp.toStringAsFixed(2)}';
    } else {
      convertedTemp = inputTemp * 9 / 5 + 32;
      result = 'C to F: ${inputTemp.toStringAsFixed(1)} => ${convertedTemp.toStringAsFixed(2)}';
    }


    setState(() {
      _convertedTemperature = convertedTemp.toStringAsFixed(2);
      _conversionHistory.insert(0, result);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Temperature Converter')),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return orientation == Orientation.portrait
              ? _buildPortraitLayout()
              : _buildLandscapeLayout();
        },
      ),
    );
  }


  Widget _buildPortraitLayout() {
    return Column(
      children: [
        _buildConversionForm(),
        Expanded(child: _buildHistoryList()),
      ],
    );
  }


  Widget _buildLandscapeLayout() {
    return Row(
      children: [
        Expanded(child: _buildConversionForm()),
        Expanded(child: _buildHistoryList()),
      ],
    );
  }


  Widget _buildConversionForm() {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Text('F to C'),
              Switch(
                value: isFahrenheitToCelsius,
                onChanged: (value) {
                  setState(() => isFahrenheitToCelsius = value);
                },
              ),
              Text('C to F'),
            ],
          ),
          TextField(
            controller: _temperatureController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'Enter temperature'),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _convertTemperature,
            child: Text('Convert'),
          ),
          SizedBox(height: 20),
          Text(
            'Converted Temperature: $_convertedTemperature',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }


  Widget _buildHistoryList() {
    return ListView.builder(
      itemCount: _conversionHistory.length,
      itemBuilder: (context, index) {
        return ListTile(title: Text(_conversionHistory[index]));
      },
    );
  }
}








