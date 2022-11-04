import 'package:flutter/material.dart';

import 'package:flutter/src/widgets/framework.dart';

ValueNotifier<double> sliderCursorValueChangeNotifier = ValueNotifier(0);

class CongestionSliderWidget extends StatelessWidget {
  CongestionSliderWidget({
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
          return Container(
            child: Slider(
                autofocus: true,
                value: newprogressvalue,
                min: 0,
                max: 100,
                activeColor: currentprogresscolor(newprogressvalue),
                onChanged: (newvalue) {
                  sliderCursorValueChangeNotifier.value = newvalue;
                },
                label: '$newprogressvalue'),
          );
        });
  }

  currentprogresscolor(double progressvalue) {
    if (progressvalue <= 50) {
      return Colors.green;
    } else if (progressvalue >= 50 && progressvalue <= 70) {
      return Colors.orange;
    }
    {
      return Colors.red;
    }
  }
}
