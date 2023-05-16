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
    // final TextEditingController locationController = TextEditingController();
    // final List<DropdownMenuEntry<LocationLabel>> locationEntries = <DropdownMenuEntry<LocationLabel>>[];
    // for (final LocationLabel location in LocationLabel.values) {
    //   locationEntries.add(
    //     DropdownMenuEntry<LocationLabel>(
    //         value: location, label: location.label, enabled: location.label != 'Oxford'
    //     ),
    //   );
    // }

    return Scaffold(
      appBar: AppBar(
        /// flutter automatically adds a back button if there is a previous page,
        /// so we need a custom button to be able to send data back to the main page
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_sharp, 
                          color: Pallete.settingsBackButtonColor,),
          onPressed: () {
            // send preferences back to Settings screen
            _sendDataBack(context);
          }
        ),
        title: const Text('Location Settings', 
                    style: TextStyle(color: Pallete.settingsTextColor)),
        automaticallyImplyLeading: false,
        backgroundColor: Pallete.settingsAppBarColor,
      ),
      backgroundColor: Pallete.settingsBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SwitchListTile(
              title: const Text("Automatically set location",
                    style: TextStyle(color: Pallete.settingsTextColor)),
              value: preferences.isLocationSetAutomatically,
              onChanged: (value) {
                setState(() {
                  preferences.isLocationSetAutomatically = value;
                });
              },
              inactiveThumbColor: Pallete.settingsSwitchListTileInactiveThumbColor,
              inactiveTrackColor: Pallete.settingsSwitchListTileInactiveTrackColor,
              activeColor: Pallete.settingsSwitchListTileActiveColor,
               shape: RoundedRectangleBorder(
                side: const BorderSide(color: Pallete.settingsSwitchListTileBorderColor),
                borderRadius: BorderRadius.circular(5),
              ), 
            ),
            SizedBox(height: 24.0),
            // DropdownMenu<LocationLabel>(
            //   initialSelection: preferences.selectedLocation,
            //   controller: locationController,
            //   label: const Text('Location', style: TextStyle(color: Pallete.settingsTextColor)),
            //   dropdownMenuEntries: locationEntries,
            //   onSelected: (LocationLabel? location) {
            //     setState(() {
            //       preferences.selectedLocation = location;
            //     });
            //   },
            //   // menuStyle: MenuStyle(
            //   //   backgroundColor: MaterialStatePropertyAll<Color>(Colors.green),
            //   //   fixedSize: MaterialStatePropertyAll(Size(480, 320)),
            //   // ),
            //
            // ),
            SizedBox(height: 24.0),
            DropdownButton<String>(
              isExpanded: true,
              value: preferences.selectedLocation,
              icon: const Icon(Icons.arrow_downward),
              elevation: 16,
              style: const TextStyle(color: Pallete.settingsTextColor),
              onChanged: (String? location) {
                setState(() {
                  preferences.selectedLocation = location!;
                });
              },
              items: locations.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            )
          ],
        ),
      ),
    );
  }
}

