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

  Key _homeKey = UniqueKey();

  void updateHomeKey() {
    setState(() {
      _homeKey = UniqueKey();
    });
  }

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
      key: _homeKey,
      appBar: AppBarWithProfile(
        context,
        activeChild: activeChild,
        onChildTap: (selectedChildren) {
          setState(() {
            activeChild = selectedChildren;
          });
          updateHomeKey();
        },
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
        ActivitiesPage(
          activeChild: activeChild,
        ),
        MilestonesChecklistOverviewPage(
          activeChild: activeChild,
        ),
        const BehaviorDictionaryPage(),
        const DoctorsPage(),
      ][currentPageIndex],
    );
  }
}
