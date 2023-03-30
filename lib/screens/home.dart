import 'package:asdigi/screens/milestones_checklist.dart';
import 'package:flutter/material.dart';
import '../components/app_bar_profile.dart';
import '../components/custom_nav_bar.dart';
import 'behavior_dictionary.dart';
import 'doctors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithProfile(context),
      bottomNavigationBar: CustomNavBar(
        currentPageIndex: currentPageIndex,
        onDestinationSelected: (int indexSelected) {
          setState(() {
            currentPageIndex = indexSelected;
          });
        },
      ),
      body: <Widget>[
        Container(
          alignment: Alignment.center,
          child: Text(
            'Activities Page',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        const MilestonesChecklistPage(),
        const BehaviorDictionaryPage(),
        const DoctorsPage(),
      ][currentPageIndex],
    );
  }
}
