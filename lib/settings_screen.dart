import 'package:flutter/material.dart';
import 'package:flutter_application_1/location_settings.dart';
import 'package:flutter_application_1/custom_components/preferences.dart';

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
  Preferences preferences = Preferences.defaultPreferences();

  @override
  void initState() {
    super.initState();
    preferences = Preferences.copy(widget.preferences);
  }

  /// sends preferences back to the previous page
  void _sendDataBack(BuildContext context) {
    Navigator.pop(context, preferences);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        /// flutter automatically adds a back button if there is a previous page,
        /// so we need a custom button to be able to send data back to the main page
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_sharp),
          onPressed: () {
            // send preferences back to Study Outside screen
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
          /// Button to go to 'Location Settings' screen
          SizedBox(height: 16.0),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.background,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onPressed: () {
                /// push the 'Location Settings' screen and wait for updated preferences
                awaitReturnPreferencesFromLocationSettingsScreen(context);
              },
              child: Text('Location Settings'),
            ),
          ),
        ],
      ),
    );
  }

  /// awaits for the returned preferences from the location settings 
  /// screen and updates the preferences on stored on this screen so 
  /// that we can access them later
  void awaitReturnPreferencesFromLocationSettingsScreen(BuildContext context) async {
    final Preferences returnedPreferences = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LocationSettingsScreen(preferences: preferences)
                                  ),
                        );
    setState(() {
      //preferences = Preferences.copy(returnedPreferences);
      preferences.isCelsius = returnedPreferences.isCelsius;
      preferences.minTemp = returnedPreferences.minTemp;
      preferences.maxTemp = returnedPreferences.maxTemp;
      preferences.workAtNight = returnedPreferences.workAtNight;
      preferences.workInRain = returnedPreferences.workInRain;
      preferences.workInSnow = returnedPreferences.workInSnow;
      preferences.workInWind = returnedPreferences.workInWind;
      preferences.isLocationSetAutomatically = returnedPreferences.isLocationSetAutomatically;
      preferences.selectedLocation = returnedPreferences.selectedLocation;
    });
  }
}
