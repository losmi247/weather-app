import 'package:flutter/material.dart';
import 'package:flutter_application_1/custom_components/locationsOptionSlider.dart';
import 'package:flutter_application_1/custom_components/pallete.dart';
import 'package:flutter_application_1/custom_components/preferences.dart';
import 'package:flutter_svg/flutter_svg.dart';

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

  LocationsOptionSlider locationSlider = LocationsOptionSlider(options: locations, 
    notifyParent:(newIndex) {
      
  },);

  @override
  void initState() {
    super.initState();
    preferences = Preferences.copy(widget.preferences);

    // initalize the location slider from preferences
    locationSlider.index = preferences.locationIndex;
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

    locationSlider.notifyParentFunction = (newIndex) {
      /// update location index in preferences
      preferences.locationIndex = newIndex;
    };

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
      backgroundColor: Pallete.settingsBackgroundDayColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SwitchListTile(
              title: const Text("Automatically set location", 
                    style: TextStyle(fontSize: 18, color: Pallete.settingsTextColor)),
              value: preferences.isLocationSetAutomatically,
              tileColor: Pallete.settignsSwitchListTileColor,
              onChanged: (value) {
                /*setState(() {
                  preferences.isLocationSetAutomatically = value;
                  if (value == true) {
                    preferences.selectedLocation = "Cambridge";
                  }
                });*/
                setState(() {
                  preferences.isLocationSetAutomatically = value;
                  if (value == true) {
                    preferences.locationIndex = 0;
                    locationSlider.sliderState.controller.animateToItem(0, 
                      duration: Duration(milliseconds: 400),
                      curve: Curves.fastOutSlowIn);
                  }
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
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),

            Container(
              decoration: BoxDecoration(
                color: Pallete.settignsSwitchListTileColor,
                borderRadius: BorderRadius.circular(5),
                border: const Border.fromBorderSide(BorderSide(
                      color: Pallete.settingsSwitchListTileBorderColor),
                ),
                //shape: 
              ),
              child: Row(
                children: [
                  SizedBox(width: MediaQuery.of(context).size.width * 0.025),
                  Expanded(
                    child: Row(
                      children: [
                         const Text('Select location', style: TextStyle(
                          color: Pallete.settingsTextColor,
                          fontSize: 18
                        )),
                        SizedBox(width: MediaQuery.of(context).size.width * 0.018,),
                        SvgPicture.asset(
                          "assets/icons/location.svg",
                          width: 27.0,
                          height: 27.0,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.025),

                  IgnorePointer(
                    ignoring: preferences.isLocationSetAutomatically,
                    child: Opacity(
                      opacity: preferences.isLocationSetAutomatically ? 0.5 : 1,
                      child: locationSlider,
                    ),
                  ),

                  SizedBox(width: MediaQuery.of(context).size.width * 0.025),

                  /*Expanded(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: preferences.selectedLocation,
                      elevation: 16,
                      iconEnabledColor: Pallete.settingsLocationDropdownArrowColor,
                      style: const TextStyle(color: Pallete.settingsTextColor),
                      // onChanged: (String? location) {
                      //   setState(() {
                      //     preferences.selectedLocation = location!;
                      //   });
                      // },
                      onChanged: (!preferences.isLocationSetAutomatically ?
                      ((String? location) {
                        setState(() {
                          preferences.selectedLocation = location!;
                        });
                      })
                          :
                      null

                      ),
                      items: locations.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      dropdownColor: Pallete.settingsLocationDropdownColor,
                    )
                  ),*/

                  
                ]
              ),
            ),
          ],
        ),
      ),
    );
  }
}

