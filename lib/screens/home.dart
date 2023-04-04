import 'package:asdigi/screens/milestones_checklist.dart';
import 'package:flutter/material.dart';
import '../components/app_bar_profile.dart';
import '../components/custom_nav_bar.dart';
import '../models/child.dart';
import '../models/user.dart';
import 'activities.dart';
import 'behavior_dictionary.dart';
import 'doctors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  int currentPageIndex = 0;
  Child? activeChild;

  bool favorite = true;
  final List<String> _filters = <String>[];

  void fetchActiveChild() async {
    activeChild = await Child.getActiveChild();
    setState(() {});
  }

  @override
  initState() {
    super.initState();
    fetchActiveChild();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithProfile(
        context,
        activeChild: activeChild,
      ),
      bottomNavigationBar: CustomNavBar(
        currentPageIndex: currentPageIndex,
        onDestinationSelected: (int indexSelected) {
          setState(() {
            currentPageIndex = indexSelected;
          });
        },
      ),
      body: <Widget>[
        const ActivitiesPage(),
        MilestonesChecklistOverviewPage(
          activeChild: activeChild,
        ),
        const BehaviorDictionaryPage(),
        const DoctorsPage(),
      ][currentPageIndex],
    );
  }
}
