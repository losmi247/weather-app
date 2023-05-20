import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/custom_components/pallete.dart';

class OptionSlider extends StatefulWidget {
  OptionSlider({
    Key? key,
    required this.options,
    required this.label,
  }) : super(key: key);

  final List<double> options;
  final String label;
  late _OptionSliderState sliderState = _OptionSliderState();

  @override
  _OptionSliderState createState() => sliderState;

  /// getters for selected index, selected value
  int get index => sliderState.selectedIndex;
  double get value => sliderState.options[sliderState.selectedIndex];

  /// setter for selected index
  set index(int newIndex){
    sliderState.selectedIndex = newIndex;
  }
  set options(List<double> newOptions){
    sliderState.setState(() { sliderState.options = newOptions; });
  }
}

class _OptionSliderState extends State<OptionSlider> {
  int selectedIndex = 0;
  List<double> options = [20];
  String label = "";

  @override
  void initState() {
    super.initState();
    options = widget.options;
    label = widget.label;
  }

  @override
  Widget build(BuildContext context) {
    /*return Expanded(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 100,
            left: 100,
            right: 100,
            child: Container(
              //width: 200, // Adjust the width as needed
              //height: 200, // Adjust the height as needed
              width: 50,
              height: 100,
              child: CupertinoPicker(
                //itemExtent: 30,
                itemExtent: 30,
                children: stringsToWidgets(),
                onSelectedItemChanged: (value) {
                  selectedIndex = value;
                },
              ),
            ),
          ),
        ],
      ),
    );*/

    return Container(
      //width: 130,
      width: 140,
      height: 120,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Text(label, style: const TextStyle(color: Pallete.settingsTextColor)),
          Positioned(
            top: 30,
            child: Container(
              width: 130,
              height: 80,
              child: CupertinoPicker(
                //itemExtent: 30,
                scrollController: FixedExtentScrollController(initialItem: selectedIndex),
                itemExtent: 30,
                children: stringsToWidgets(),
                onSelectedItemChanged: (value) {
                  selectedIndex = value;
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
      b.add(Center(child: Text(item.toInt().toString(), style: const TextStyle(color: Pallete.settingsTextColor))));
    }
    return b;
  }
}