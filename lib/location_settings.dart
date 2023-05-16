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
    final TextEditingController locationController = TextEditingController();
    final List<DropdownMenuEntry<LocationLabel>> locationEntries = <DropdownMenuEntry<LocationLabel>>[];
    for (final LocationLabel location in LocationLabel.values) {
      locationEntries.add(
        DropdownMenuEntry<LocationLabel>(
            value: location, label: location.label, enabled: location.label != 'Oxford'
        ),
      );
    }

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
              title: const Text("Automatically set location",
                    style: TextStyle(color: Pallete.locationSettingsTextColor)),
              value: preferences.isLocationSetAutomatically,
              onChanged: (value) {
                setState(() {
                  preferences.isLocationSetAutomatically = value;
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
            SizedBox(height: 24.0),
            DropdownMenu<LocationLabel>(
              initialSelection: preferences.selectedLocation,
              controller: locationController,
              label: const Text('Location', style: TextStyle(color: Pallete.locationTextColor)),
              dropdownMenuEntries: locationEntries,
              onSelected: (LocationLabel? location) {
                setState(() {
                  preferences.selectedLocation = location;
                });
              },
            )
          ],
        ),
      ),
    );
  }
}

