import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spot/core/constants.dart';
import 'package:spot/presentation/splash_screen/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: SplashController(),
        builder: (controller) {
          return Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.white.withOpacity(.9),
            // decoration: const BoxDecoration(
            //     gradient: LinearGradient(
            //         colors: gradientList,
            //         begin: Alignment.topLeft,
            //         end: Alignment.bottomRight)
            //         ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                    radius: 50,
                    child: ClipOval(
                        child:
                            Image.asset('asset/spot_logo/play_store_512.png'))),
                AnimatedTextKit(animatedTexts: [
                  TypewriterAnimatedText('Spot',
                      cursor: '.',
                      speed: const Duration(milliseconds: 300),
                      textStyle: Theme.of(context).textTheme.headline2)
                ]),
              ],
            ),
          );
        });
  }
}
