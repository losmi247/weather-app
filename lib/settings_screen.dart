import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  final bool isCelsius;
  final double minTemp;
  final double maxTemp;

  const SettingsScreen({
    Key? key,
    required this.isCelsius,
    required this.minTemp,
    required this.maxTemp,
  }) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isCelsius = false;
  double _minTemp = 0;
  double _maxTemp = 0;

  @override
  void initState() {
    super.initState();
    _isCelsius = widget.isCelsius;
    _minTemp = widget.minTemp;
    _maxTemp = widget.maxTemp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          SwitchListTile(
            title: Text('Use Celsius'),
            value: _isCelsius,
            onChanged: (value) {
              setState(() {
                _isCelsius = value;
              });
            },
          ),
          SizedBox(height: 16.0),
          Text('Temperature range'),
          SizedBox(height: 8.0),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Min temperature',
                  ),
                  initialValue: _minTemp.toString(),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      _minTemp = double.tryParse(value) ?? 0;
                    });
                  },
                ),
              ),
              SizedBox(width: 16.0),
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Max temperature',
                  ),
                  initialValue: _maxTemp.toString(),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      _maxTemp = double.tryParse(value) ?? 0;
                    });
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
