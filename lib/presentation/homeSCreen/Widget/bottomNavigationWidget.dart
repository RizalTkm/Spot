import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:spot/core/constants.dart';
import 'package:spot/presentation/addSpotScreen/addSpot.dart';
import 'package:spot/presentation/homeSCreen/homescreen.dart';
import 'package:spot/presentation/settings/Settings_Screen.dart';

final ValueNotifier<int> navigationChangingNotifier = ValueNotifier(0);

final List pageList = [Homescreen(), AddSpotscreen(), SettingsScreen()];

class BottomNavigationWidget extends StatelessWidget {
  BottomNavigationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: navigationChangingNotifier,
      builder: (context, int newindex, _) {
        return BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          unselectedItemColor: Colors.blueGrey,
          selectedItemColor: kblack,
          currentIndex: newindex,
          onTap: (index) {
            navigationChangingNotifier.value = index;
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.add_a_photo), label: 'Create'),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: 'Settings'),
          ],
          elevation: 100,
          backgroundColor: Colors.grey.withOpacity(.8),
        );
      },
    );
  }
}
