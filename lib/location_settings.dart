import 'package:flutter/material.dart';
import 'package:flutter_application_1/custom_components/pallete.dart';
import 'package:flutter_application_1/custom_components/preferences.dart';

class LocationSettingsScreen extends StatefulWidget {
  final Preferences preferences;

  const LocationSettingsScreen({
    Key? key,
    required this.preferences,
  }) : super(key: key);

  @override
  _LocationSettingsScreenState createState() => _LocationSettingsScreenState();
}

class _LocationSettingsScreenState extends State<LocationSettingsScreen> {
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
          icon: const Icon(Icons.arrow_back_ios_new_sharp, 
                          color: Pallete.locationSettingsBackButtonColor,),
          onPressed: () {
            // send preferences back to Settings screen
            _sendDataBack(context);
          }
        ),
        title: const Text('Location Settings', 
                    style: TextStyle(color: Pallete.locationSettingsTextColor)),
        automaticallyImplyLeading: false,
        backgroundColor: Pallete.locationSettingsAppBarColor,
      ),
      backgroundColor: Pallete.locationSettingsBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SwitchListTile(
              title: const Text('Enable Location',
                    style: TextStyle(color: Pallete.locationSettingsTextColor)),
              value: preferences.isLocationEnabled,
              onChanged: (value) {
                setState(() {
                  preferences.isLocationEnabled = value;
                });
              },
              inactiveThumbColor: Pallete.locationSettingsSwitchListTileInactiveThumbColor,
              inactiveTrackColor: Pallete.locationSettingsSwitchListTileInactiveTrackColor,
              activeColor: Pallete.locationSettingsSwitchListTileActiveColor,
               shape: RoundedRectangleBorder(
                side: const BorderSide(color: Pallete.locationSettingsSwitchListTileBorderColor),
                borderRadius: BorderRadius.circular(5),
              ), 
            ),
          ],
        ),
      ),
    );
  }
}
