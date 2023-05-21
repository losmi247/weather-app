import 'package:flutter/material.dart';
import 'package:flutter_application_1/custom_components/option_slider.dart';
import 'package:flutter_application_1/custom_components/pallete.dart';
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
  /// static?
  static Preferences preferences = Preferences.defaultPreferences();
  /// don't access these OptionSliders for min/max temp, access
  /// preferences.minTemp, preferences.maxTemp,
  /// except they are now getters, not fields in the 
  /// Preferences class
  OptionSlider minTempSlider = OptionSlider(
    options: (preferences.isCelsius ? Preferences.minTemperaturesCelsius : 
                                     Preferences.minTemperaturesFahrenheit),
    label: "Min temperature",
    notifyParent: (newIndex) {},
  );
  OptionSlider maxTempSlider = OptionSlider(
    options: (preferences.isCelsius ? Preferences.maxTemperaturesCelsius : 
                                     Preferences.maxTemperaturesFahrenheit),
    label: "Max temperature",
    notifyParent: (newIndex) {},
  );

  @override
  void initState() {
    super.initState();
    preferences = Preferences.copy(widget.preferences);
    /// set up the min/max temperature
    /// sliders to current indices
    minTempSlider.index = preferences.minTempIndex;
    maxTempSlider.index = preferences.maxTempIndex;
  }

  /// sends preferences back to the previous page
  void _sendDataBack(BuildContext context) {
    /// update preferences for min/max temperature
    /// when going back to 'study outside' screen
    preferences.minTempIndex = minTempSlider.index;
    preferences.maxTempIndex = maxTempSlider.index;
    Navigator.pop(context, preferences);
  }

  /// this function takes the new index that the
  /// minTempSlider has been set to, and pushes the 
  /// maxTempSlider up to the first temperature that 
  /// is > than the current temperature on minTempSlider
  void validMinTemperatureRangeLogic(newIndex){
    if(minTempSlider.options[newIndex] >= maxTempSlider.value){
      int pos = maxTempSlider.index;
      while(maxTempSlider.options[pos] <= minTempSlider.options[newIndex]){
        pos++;
      }
      maxTempSlider.sliderState.controller.animateToItem(pos, 
        duration: Duration(milliseconds: 400),
        curve: Curves.fastOutSlowIn);
    }
    else{
      preferences.minTempIndex = newIndex;
    }
  }
  /// this function takes the new index that the
  /// maxTempSlider has been set to, and pushes the 
  /// minTempSlider down to the first temperature that 
  /// is < than the current temperature on maxTempSlider
  void validMaxTemperatureRangeLogic(newIndex){
    if(maxTempSlider.options[newIndex] <= minTempSlider.value){
      int pos = minTempSlider.index;
      while(minTempSlider.options[pos] >= maxTempSlider.options[newIndex]){
        pos--;
      }
      minTempSlider.sliderState.controller.animateToItem(pos, 
        duration: Duration(milliseconds: 400),
        curve: Curves.fastOutSlowIn);
    }
    else{
      preferences.maxTempIndex = newIndex;
    }
  }

  @override
  Widget build(BuildContext context) {
    minTempSlider.notifyParent = (newIndex) {
      validMinTemperatureRangeLogic(newIndex);
    };
    maxTempSlider.notifyParent = (newIndex) {
      validMaxTemperatureRangeLogic(newIndex);
    };

    return Scaffold(
      appBar: AppBar(
        /// flutter automatically adds a back button if there is a previous page,
        /// so we need a custom button to be able to send data back to the main page
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_sharp,
                color: Pallete.settingsBackButtonColor),
            onPressed: () {
              // send preferences back to Study Outside screen
              _sendDataBack(context);
            }),
        title: const Text('Settings',
            style: TextStyle(color: Pallete.settingsTextColor)),
        automaticallyImplyLeading: false,
        backgroundColor: Pallete.settingsAppBarColor,
      ),
      backgroundColor: Pallete.settingsBackgroundDayColor,
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          SwitchListTile(
            title: const Text('Use Celsius',
                style: TextStyle(color: Pallete.settingsTextColor)),
            value: preferences.isCelsius,
            onChanged: (value) {
              setState(() {
                preferences.isCelsius = value;
                minTempSlider.sliderOptions = (preferences.isCelsius ? 
                                     Preferences.minTemperaturesCelsius : 
                                     Preferences.minTemperaturesFahrenheit);
                maxTempSlider.sliderOptions = (preferences.isCelsius ? 
                                     Preferences.maxTemperaturesCelsius : 
                                     Preferences.maxTemperaturesFahrenheit);
              });
            },
            inactiveThumbColor:
                Pallete.settingsSwitchListTileInactiveThumbColor,
            inactiveTrackColor:
                Pallete.settingsSwitchListTileInactiveTrackColor,
            activeColor: Pallete.settingsSwitchListTileActiveColor,
            shape: ContinuousRectangleBorder(
              side: const BorderSide(
                  color: Pallete.settingsSwitchListTileBorderColor),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.03),
          /// OLD MIN/MAX TEMP SETTINGS
          /*const Text('Temperature range',
              style: TextStyle(color: Pallete.settingsTextColor)),
          SizedBox(height: MediaQuery.of(context).size.height * 0.005),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Min temperature',
                    labelStyle: TextStyle(color: Pallete.settingsTextColor),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Pallete
                              .settingsTextFormFieldUnderlineEnabledColor),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Pallete
                              .settingsTextFormFieldUnderlineFocusedColor),
                    ),
                  ),
                  style: const TextStyle(color: Pallete.settingsTextColor),
                  initialValue: preferences.minTemp.toString(),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      preferences.minTemp = double.tryParse(value) ?? 0;
                    });
                  },
                  cursorColor: Pallete.settingsTextFormFieldCursorColor,
                ),
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.06),
              Expanded(
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Max temperature',
                    labelStyle: TextStyle(color: Pallete.settingsTextColor),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Pallete
                              .settingsTextFormFieldUnderlineEnabledColor),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Pallete
                              .settingsTextFormFieldUnderlineFocusedColor),
                    ),
                  ),
                  style: const TextStyle(color: Pallete.settingsTextColor),
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
          ),*/

          /// NEW MIN/MAX TEMPS SETTINGS
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              minTempSlider,
              maxTempSlider
            ],
          ), 
          
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          const Text('Willing to work in:',
              style: TextStyle(color: Pallete.settingsTextColor)),
          SizedBox(height: MediaQuery.of(context).size.height * 0.024),
          SwitchListTile(
            title: const Text('Rain',
                style: TextStyle(color: Pallete.settingsTextColor)),
            value: preferences.workInRain,
            onChanged: (value) {
              setState(() {
                preferences.workInRain = value;
              });
            },
            inactiveThumbColor:
                Pallete.settingsSwitchListTileInactiveThumbColor,
            inactiveTrackColor:
                Pallete.settingsSwitchListTileInactiveTrackColor,
            activeColor: Pallete.settingsSwitchListTileActiveColor,
            shape: ContinuousRectangleBorder(
              side: const BorderSide(
                  color: Pallete.settingsSwitchListTileBorderColor),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          SwitchListTile(
            title: const Text('Snow',
                style: TextStyle(color: Pallete.settingsTextColor)),
            value: preferences.workInSnow,
            onChanged: (value) {
              setState(() {
                preferences.workInSnow = value;
              });
            },
            inactiveThumbColor:
                Pallete.settingsSwitchListTileInactiveThumbColor,
            inactiveTrackColor:
                Pallete.settingsSwitchListTileInactiveTrackColor,
            activeColor: Pallete.settingsSwitchListTileActiveColor,
            shape: ContinuousRectangleBorder(
              side: const BorderSide(
                  color: Pallete.settingsSwitchListTileBorderColor),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          SwitchListTile(
            title: const Text('Wind',
                style: TextStyle(color: Pallete.settingsTextColor)),
            value: preferences.workInWind,
            onChanged: (value) {
              setState(() {
                preferences.workInWind = value;
              });
            },
            inactiveThumbColor:
                Pallete.settingsSwitchListTileInactiveThumbColor,
            inactiveTrackColor:
                Pallete.settingsSwitchListTileInactiveTrackColor,
            activeColor: Pallete.settingsSwitchListTileActiveColor,
            shape: ContinuousRectangleBorder(
              side: const BorderSide(
                  color: Pallete.settingsSwitchListTileBorderColor),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          SwitchListTile(
            title: const Text('At night',
                style: TextStyle(color: Pallete.settingsTextColor)),
            value: preferences.workAtNight,
            onChanged: (value) {
              setState(() {
                preferences.workAtNight = value;
              });
            },
            inactiveThumbColor:
                Pallete.settingsSwitchListTileInactiveThumbColor,
            inactiveTrackColor:
                Pallete.settingsSwitchListTileInactiveTrackColor,
            activeColor: Pallete.settingsSwitchListTileActiveColor,
            shape: ContinuousRectangleBorder(
              side: const BorderSide(
                  color: Pallete.settingsSwitchListTileBorderColor),
              borderRadius: BorderRadius.circular(10),
            ),
          ),

          /// Button to go to 'Location Settings' screen
          SizedBox(height: MediaQuery.of(context).size.height * 0.025),
          SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.05,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Pallete.settingsLocationSettingsButtonColor,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onPressed: () {
                /// before going to 'Location Settings', update 
                /// the preferences for min/max temperature
                /// (maybe can leave it for later, when we leave this
                /// screen to go back to 'Study Outside Screen', 
                /// but it's safer this way)
                preferences.minTempIndex = minTempSlider.index;
                preferences.maxTempIndex = maxTempSlider.index;
                /// push the 'Location Settings' screen and wait for updated preferences
                awaitReturnPreferencesFromLocationSettingsScreen(context);
              },
              child: const Text('Location Settings', 
                            style: TextStyle(fontSize: 18.0, fontFamily: 'Roboto')),
            ),
          ),
        ],
      ),
    );
  }

  /// awaits for the returned preferences from the location settings
  /// screen and updates the preferences on stored on this screen so
  /// that we can access them later
  void awaitReturnPreferencesFromLocationSettingsScreen(
      BuildContext context) async {
    final Preferences returnedPreferences = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              LocationSettingsScreen(preferences: preferences)),
    );
    setState(() {
      //preferences = Preferences.copy(returnedPreferences);
      preferences.isCelsius = returnedPreferences.isCelsius;
      /// minTemp, maxTemp are now getters
      //preferences.minTemp = returnedPreferences.minTemp;
      //preferences.maxTemp = returnedPreferences.maxTemp;
      preferences.workAtNight = returnedPreferences.workAtNight;
      preferences.workInRain = returnedPreferences.workInRain;
      preferences.workInSnow = returnedPreferences.workInSnow;
      preferences.workInWind = returnedPreferences.workInWind;
      preferences.isLocationSetAutomatically =
          returnedPreferences.isLocationSetAutomatically;
      preferences.selectedLocation = returnedPreferences.selectedLocation;

      /// update the min/max temp indices when you come back from 
      /// 'location settings' screen (even they won't be changed there)
      preferences.minTempIndex = returnedPreferences.minTempIndex;
      preferences.maxTempIndex = returnedPreferences.maxTempIndex;
    });
  }
}
