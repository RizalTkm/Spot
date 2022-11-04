import 'package:flutter/material.dart';

import 'package:flutter/src/widgets/framework.dart';

class DemoSlider extends StatefulWidget {
  const DemoSlider({
    super.key,
  });

  @override
  State<DemoSlider> createState() => _DemoSliderState();
}

class _DemoSliderState extends State<DemoSlider> {
  double currentprogressvalue = 0;

  @override
  Widget build(BuildContext context) {
    return Slider(
        activeColor: currentprogresscolor(currentprogressvalue),
        min: 0,
        max: 100,
        divisions: 100,
        label: '${currentprogressvalue.roundToDouble()}',
        value: currentprogressvalue,
        onChanged: (newvalue) {
          setState(() {
            currentprogressvalue = newvalue;
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
