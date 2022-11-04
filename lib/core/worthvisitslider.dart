import 'package:flutter/material.dart';

ValueNotifier<double> sliderCursorValueChangeNotifier = ValueNotifier(0);

class WorthvisitSlider extends StatelessWidget {
  WorthvisitSlider({
    super.key,
  });

  // onchangevaluefunction() {
  //   final onchangevalue = sliderCursorValueChangeNotifier.value;
  // }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: sliderCursorValueChangeNotifier,
        builder: (context, newprogressvalue, _) {
          return Slider(
              label: '$newprogressvalue',
              value: newprogressvalue,
              min: 0,
              max: 100,
              activeColor: currentprogresscolor(newprogressvalue),
              onChanged: (newvalue) {
                sliderCursorValueChangeNotifier.value = newvalue;
              });
        });
  }

  currentprogresscolor(double progressvalue) {
    if (progressvalue <= 50) {
      return Colors.red;
    } else if (progressvalue >= 50 && progressvalue <= 70) {
      return Colors.orange;
    }
    {
      return Colors.green;
    }
  }
}
