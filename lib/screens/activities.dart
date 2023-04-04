import 'package:flutter/material.dart';
import '../components/activity_section.dart';
import '../components/custom_material_item.dart';
import '../components/custom_reccomendation_item.dart';
import '../models/child.dart';
import '../models/developmental_resource.dart';
import '../models/milestone.dart';
import 'activity_content.dart';

class ActivitiesPage extends StatefulWidget {
  const ActivitiesPage({super.key});

  @override
  State<ActivitiesPage> createState() => _ActivitiesPageState();
}

class _ActivitiesPageState extends State<ActivitiesPage> {
  List<DevelopmentalResourceOverview>? allResourceOverviews;
  List<DevelopmentalResourceOverview>? socialResourceOverviews;
  List<DevelopmentalResourceOverview>? languageResourceOverviews;
  List<DevelopmentalResourceOverview>? cognitiveResourceOverviews;
  List<DevelopmentalResourceOverview>? movementResourceOverviews;
  Child? activeChild;

  void fetchActiveChild() async {
    activeChild = await Child.getActiveChild();
    setState(() {});
  }

  void fetchAllResourceOverviews() async {
    allResourceOverviews =
        await DevelopmentalResourceOverview.getAllFromFirestore();
    loadAllResourceOverviews();
    setState(() {});
  }

  void loadAllResourceOverviews() {
    socialResourceOverviews = allResourceOverviews!
        .where((element) =>
            element.milestoneCategory == MilestoneOverviewItem.social)
        .toList();
    languageResourceOverviews = allResourceOverviews!
        .where((element) =>
            element.milestoneCategory == MilestoneOverviewItem.language)
        .toList();
    cognitiveResourceOverviews = allResourceOverviews!
        .where((element) =>
            element.milestoneCategory == MilestoneOverviewItem.cognitive)
        .toList();
    movementResourceOverviews = allResourceOverviews!
        .where((element) =>
            element.milestoneCategory == MilestoneOverviewItem.movement)
        .toList();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchActiveChild();
    fetchAllResourceOverviews();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        child: DefaultTabController(
          length: 4,
          child: Scaffold(
            appBar: AppBar(
              toolbarHeight: 0,
              bottom: const TabBar(
                isScrollable: true,
                tabs: [
                  Tab(
                    child: Text(
                      'Social',
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Language',
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Cognitive',
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Movement',
                    ),
                  ),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                allResourceOverviews != null && activeChild != null
                    ? ResourcesSection(
                        activeChild: activeChild!,
                        allResourceOverviews: socialResourceOverviews!,
                      )
                    : const Center(
                        child: CircularProgressIndicator(),
                      ),
                allResourceOverviews != null && activeChild != null
                    ? ResourcesSection(
                        activeChild: activeChild!,
                        allResourceOverviews: languageResourceOverviews!,
                      )
                    : const Center(
                        child: CircularProgressIndicator(),
                      ),
                allResourceOverviews != null && activeChild != null
                    ? ResourcesSection(
                        activeChild: activeChild!,
                        allResourceOverviews: cognitiveResourceOverviews!,
                      )
                    : const Center(
                        child: CircularProgressIndicator(),
                      ),
                allResourceOverviews != null && activeChild != null
                    ? ResourcesSection(
                        activeChild: activeChild!,
                        allResourceOverviews: movementResourceOverviews!,
                      )
                    : const Center(
                        child: CircularProgressIndicator(),
                      ),
              ],
            ),
          ),
        ));
  }
}
