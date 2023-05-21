import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/custom_components/pallete.dart';

class LocationsOptionSlider extends StatefulWidget {
  LocationsOptionSlider({
    Key? key,
    required this.options,
    required this.notifyParent,
  }) : super(key: key);

  List<String> options;
  /// function to notify the settings screen that
  /// the slider's value has been changed, so that
  /// we can update the other sliders value so that
  /// the temperature range is l < r (valid)
  Function(int newIndex) notifyParent;
  late _LocationsOptionSliderState sliderState = _LocationsOptionSliderState();

  @override
  _LocationsOptionSliderState createState() => sliderState;

  /// getters for selected index, selected value
  int get index => sliderState.selectedIndex;
  String get value => sliderState.options[sliderState.selectedIndex];

  /// setter for selected index
  set index(int newIndex){
    sliderState.selectedIndex = newIndex;
  }
  set sliderOptions(List<String> newOptions){
    options = newOptions;
    sliderState.setState(() { sliderState.options = newOptions; });
  }
  set notifyParentFunction(Function(int newIndex) v){
    notifyParent = v;
  }
}

class _LocationsOptionSliderState extends State<LocationsOptionSlider> {
  int selectedIndex = 0;
  List<String> options = ["a"];
  FixedExtentScrollController controller = FixedExtentScrollController();

  @override
  void initState() {
    super.initState();
    options = widget.options;
    controller = FixedExtentScrollController(
      initialItem: selectedIndex,
    );
  }

  /// previously:
  /// text top: 0
  /// second positioned top: 30
  /// main container height: 120
  @override
  Widget build(BuildContext context) {
    return Container(
      //width: 130,
      width: 200,
      height: 200,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Positioned(
            //top: 35,
            child: Container(
              width: 200,
              height: 200,
              child: CupertinoPicker(
                scrollController: controller,
                itemExtent: 30,
                children: stringsToWidgets(),
                onSelectedItemChanged: (value) {
                  selectedIndex = value;
                  widget.notifyParent(value);
                },
                backgroundColor: Color.fromRGBO(0, 0, 0, 0),
              ),
            ),
          ),
        ],
      )    
    );
  }

  List<Widget> stringsToWidgets() {
    List<Center> b = [];
    for (var item in options) {
      b.add(Center(child: Text(item, style: const TextStyle(color: Pallete.settingsTextColor))));
    }
    return b;
  }
}