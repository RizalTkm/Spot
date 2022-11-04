import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:spot/core/worthvisitslider.dart';

class FixedSlider extends StatelessWidget {
  const FixedSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return Slider(
        value: sliderCursorValueChangeNotifier.value,
        activeColor:
            currentprogresscolor(sliderCursorValueChangeNotifier.value),
        min: 0,
        max: 100,
        onChanged: (Value) {});
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
