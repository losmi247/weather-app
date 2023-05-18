import 'package:flutter/material.dart';
import 'package:flutter_application_1/custom_components/pallete.dart';

import '../constants.dart';

class SliderWithTimeLabels extends StatefulWidget {
  SliderWithTimeLabels({
    Key? key,
    required this.minValue,
    required this.maxValue,
    required this.initialValue,
  }) : super(key: key);

  final double minValue;
  final double maxValue;
  final double initialValue;
  late _SliderWithTimeLabelsState sliderState = _SliderWithTimeLabelsState();

  @override
  _SliderWithTimeLabelsState createState() => sliderState;

  double get value => sliderState.sliderValue;
}

class _SliderWithTimeLabelsState extends State<SliderWithTimeLabels> {
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
                    label: getStringForTimeDelta(sliderValue.toInt() *
                        Constants.MINUTES_TO_MILLISECONDS),
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
                child: Text(
                    getStringForTimeDelta(widget.minValue.toInt() *
                        Constants.MINUTES_TO_MILLISECONDS),
                    style: TextStyle(fontSize: 14)),
              ),
              Positioned(
                bottom: 5,
                right: 15,
                child: Text(
                    getStringForTimeDelta(widget.maxValue.toInt() *
                        Constants.MINUTES_TO_MILLISECONDS),
                    style: TextStyle(fontSize: 14)),
              ),
              Positioned(
                left: MediaQuery.of(context).size.width / 2 - 75,
                top: -4,
                child: Text(
                    "Revise for " +
                        getStringForTimeDelta(sliderValue.toInt() *
                            Constants.MINUTES_TO_MILLISECONDS),
                    style: TextStyle(fontSize: 20)),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String getStringForTimeDelta(int timeDelta, {int digits = 1}) {
    if (timeDelta == 0) {
      return '0m';
    }

    if (timeDelta >= (1000 * 60 * 60 * 24 * 365) * (1 - 0.05 / 12)) {
      double years = timeDelta / (1000 * 60 * 60 * 24 * 365);
      return '${years.toStringAsFixed(years.truncateToDouble() == years ? 0 : digits)}yr';
    } else if (timeDelta >= (1000 * 60 * 60 * 24 * 30) * (1 - 0.05 / 30)) {
      // months all have 30 days now
      double months = timeDelta / (1000 * 60 * 60 * 24 * 30);
      return '${months.toStringAsFixed(months.truncateToDouble() == months ? 0 : digits)}months';
    } else if (timeDelta >= (1000 * 60 * 60 * 24) * (1 - 0.05 / 24)) {
      double days = timeDelta / (1000 * 60 * 60 * 24);
      return '${days.toStringAsFixed(days.truncateToDouble() == days ? 0 : digits)}d';
    } else if (timeDelta >= (1000 * 60 * 60) * (1 - 0.05 / 60)) {
      double hours = timeDelta / (1000 * 60 * 60);
      return '${hours.toStringAsFixed(hours.truncateToDouble() == hours ? 0 : digits)}h';
    } else if (timeDelta >= (1000 * 60) * (1 - 0.05 / 60)) {
      double minutes = timeDelta / (1000 * 60);
      return '${minutes.toStringAsFixed(minutes.truncateToDouble() == minutes ? 0 : digits)}m';
    } else if (timeDelta >= (1000) * (1 - 0.05 / 1)) {
      double seconds = timeDelta / (1000);
      return '${seconds.toStringAsFixed(seconds.truncateToDouble() == seconds ? 0 : digits)}s';
    } else {
      return '${timeDelta.toStringAsFixed(digits)}ms';
    }
  }
}
