import 'package:flutter/material.dart';

class InputRangeSlider extends StatefulWidget {
  final double initMax;
  final double initMin;

  const InputRangeSlider({super.key, required this.initMax, required this.initMin});

  @override
  State<InputRangeSlider> createState() => _InputRangeSliderState();
}

class _InputRangeSliderState extends State<InputRangeSlider> {
  final double max = 10000;
  final double min = 0;
  late RangeValues _currentRangeValues;

  @override
  void initState() {
    _currentRangeValues = RangeValues(widget.initMin, widget.initMax);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant InputRangeSlider oldWidget) {
    _currentRangeValues = RangeValues(widget.initMin, widget.initMax);
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return RangeSlider(
        values: _currentRangeValues,
        max: max,
        divisions: 10,
        activeColor: Colors.black87,
        labels: RangeLabels(_currentRangeValues.start.round().toString(), _currentRangeValues.start.round().toString()),
        onChanged: (RangeValues values) {
          if (values.start < values.end){
            setState(() {
              _currentRangeValues = values;
            });
          }
        }
    );
  }
}
