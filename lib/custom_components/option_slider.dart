import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/custom_components/pallete.dart';

class OptionSlider extends StatefulWidget {
  OptionSlider({
    Key? key,
    required this.options,
    required this.label,
    required this.notifyParent,
  }) : super(key: key);

  List<double> options;
  final Widget label;
  /// function to notify the settings screen that
  /// the slider's value has been changed, so that
  /// we can update the other sliders value so that
  /// the temperature range is l < r (valid)
  Function(int newIndex) notifyParent;
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
  set sliderOptions(List<double> newOptions){
    options = newOptions;
    sliderState.setState(() { sliderState.options = newOptions; });
  }
  set notifyParentFunction(Function(int newIndex) v){
    notifyParent = v;
  }
}

class _OptionSliderState extends State<OptionSlider> {
  int selectedIndex = 0;
  List<double> options = [20];
  late Widget label;
  FixedExtentScrollController controller = FixedExtentScrollController();

  @override
  void initState() {
    super.initState();
    options = widget.options;
    label = widget.label;
    controller = FixedExtentScrollController(
      initialItem: selectedIndex,
    );
  }

  /// previously:
  /// text top: 0
  /// second positioned top: 30
  /// main container height: 120
  /// main container width: 140
  @override
  Widget build(BuildContext context) {
    return Container(
      //width: 130,
      width: 160,
      height: 125,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Positioned(
            top: 5,
            child: label
            //Text(label, style: const TextStyle(color: Pallete.settingsTextColor)),
          ),
          Positioned(
            top: 35,
            child: Container(
              width: 130,
              height: 80,
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
      b.add(Center(child: Text(item.toInt().toString(), style: const TextStyle(color: Pallete.settingsTextColor))));
    }
    return b;
  }
}