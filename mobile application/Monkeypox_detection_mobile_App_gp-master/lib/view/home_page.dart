import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:monkeybox_final/utilities/app_colors.dart';
import '../Cubit/theme_cubit/theme_cubit.dart';
import 'navigation_screens/about_us.dart';
import 'navigation_screens/detection.dart';
import 'navigation_screens/home.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _testState();
}

class _testState extends State<HomePage> {
  int _currentIndex = 0;
  List<Widget> widgetsList = [
    homeScreen(),
    detectionScreen(),
    aboutUsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: widgetsList[_currentIndex],
        bottomNavigationBar: BottomNavyBar(
          selectedIndex: _currentIndex,
          itemCornerRadius: 24,
          curve: Curves.easeIn,
          onItemSelected: (index) => setState(() => _currentIndex = index),
          items: <BottomNavyBarItem>[
            BottomNavyBarItem(
              icon: const Icon(Icons.home_outlined),
              title: const Text('Home'),
              activeColor: context.watch<ThemeCubit>().state.isDark == true ?Colors.white:  clr.primaryColor,
              inactiveColor: Colors.grey,
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              icon: const Icon(Icons.camera_alt_outlined),
              title: const Text('Detection'),
              activeColor: context.watch<ThemeCubit>().state.isDark == true ?Colors.white:  clr.primaryColor,
              inactiveColor: Colors.grey,
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              icon: const Icon(Icons.person),
              title: const Text('About Us'),
              activeColor: context.watch<ThemeCubit>().state.isDark == true ?Colors.white:  clr.primaryColor,
              inactiveColor: Colors.grey,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
