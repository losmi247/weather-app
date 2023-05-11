import 'package:flutter/material.dart';
import 'package:flutter_application_1/preferences.dart';

class SettingsScreen extends StatefulWidget {
  final Preferences preferences;

  const SettingsScreen({
    Key? key,
    required this.preferences,
  }) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  Preferences preferences = Preferences(isCelsius: true, minTemp: 0, maxTemp: 0,
                                        workInRain: false, workInSnow: false, 
                                        workInWind: false, workAtNight: false);

  @override
  void initState() {
    super.initState();
    preferences = Preferences.copy(widget.preferences);
  }

  @override
  Widget build(BuildContext context) {
    
    /// sends preferences back to the previous page
    void _sendDataBack(BuildContext context) {
      Navigator.pop(context, preferences);
    }

    return Scaffold(
      appBar: AppBar(
        /// flutter automatically adds a back button if there is a previous page,
        /// so we need a custom button to be able to send data back to the main page
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_sharp),
          onPressed: () {
            // send preferences back
            _sendDataBack(context);
          }
        ),
        title: Text('Settings'),
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          SwitchListTile(
            title: Text('Use Celsius'),
            value: preferences.isCelsius,
            onChanged: (value) {
              setState(() {
                preferences.isCelsius = value;
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
                  initialValue: preferences.minTemp.toString(),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      preferences.minTemp = double.tryParse(value) ?? 0;
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
                  initialValue: preferences.maxTemp.toString(),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      preferences.maxTemp = double.tryParse(value) ?? 0;
                    });
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 16.0),
          Text('Willing to work in:'),
          SwitchListTile(
            title: Text('Rain'),
            value: preferences.workInRain,
            onChanged: (value) {
              setState(() {
                preferences.workInRain = value;
              });
            },
          ),
          SwitchListTile(
            title: Text('Snow'),
            value: preferences.workInSnow,
            onChanged: (value) {
              setState(() {
                preferences.workInSnow = value;
              });
            },
          ),
          SwitchListTile(
            title: Text('Wind'),
            value: preferences.workInWind,
            onChanged: (value) {
              setState(() {
                preferences.workInWind = value;
              });
            },
          ),
          SwitchListTile(
            title: Text('At night'),
            value: preferences.workAtNight,
            onChanged: (value) {
              setState(() {
                preferences.workAtNight = value;
              });
            },
          ),
        ],
      ),
    );
  }
}
