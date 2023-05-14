import 'package:flutter/material.dart';
import 'package:flutter_application_1/pallete.dart';

class SliderWithLabels extends StatefulWidget {
  const SliderWithLabels({
    Key? key,
    required this.minValue,
    required this.maxValue,
    required this.initialValue,
  }) : super(key: key);

  final double minValue;
  final double maxValue;
  final double initialValue;

  @override
  _SliderWithLabelsState createState() => _SliderWithLabelsState();

  /// getter for the slider value
  double get value => _SliderWithLabelsState().sliderValue;
}

class _SliderWithLabelsState extends State<SliderWithLabels> {
  double minValue = 0;
  double maxValue = 12;
  double sliderValue = 0;

  @override
  void initState() {
    super.initState();
    sliderValue = widget.initialValue;
    minValue = widget.minValue;
    maxValue = widget.maxValue;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.1,
          child: Stack(
            children: [
              Positioned(
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    thumbColor: Pallete.sliderThumbColor,
                    //thumbShape: 
                  ),
                  child: Slider(
                    value: sliderValue,
                    min: minValue,
                    max: maxValue,
                    divisions: (maxValue - minValue).toInt(),
                    label: '${sliderValue.toInt()}',
                    onChanged: (value) {
                      setState(() {
                        sliderValue = value;
                      });
                    },
                    activeColor: Pallete.sliderActiveColor,
                    inactiveColor: Pallete.sliderInactiveColor,
                  ),
                ),
              ),
              Positioned(
                bottom: 5,
                left: 20,
                child: Text(widget.minValue.toInt().toString(), 
                        style: TextStyle(fontSize: 14)),
              ),
              Positioned(
                bottom: 5,
                right: 15,
                child: Text(widget.maxValue.toInt().toString(), 
                        style: TextStyle(fontSize: 14)),
              ),
              Positioned(
                left: MediaQuery.of(context).size.width / 2 - 75,
                top: -4,
                child: Text("Revise for " + sliderValue.toInt().toString() + "h", 
                        style: TextStyle(fontSize: 20)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
