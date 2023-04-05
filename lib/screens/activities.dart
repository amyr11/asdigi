import 'package:flutter/material.dart';
import '../components/activity_section.dart';
import '../components/custom_material_item.dart';
import '../components/custom_reccomendation_item.dart';
import '../models/child.dart';
import '../models/developmental_resource.dart';
import '../models/milestone.dart';
import 'activity_content.dart';

class ActivitiesPage extends StatefulWidget {
  Child? activeChild;

  ActivitiesPage({
    super.key,
    required this.activeChild,
  });

  @override
  State<ActivitiesPage> createState() => _ActivitiesPageState();
}

class _ActivitiesPageState extends State<ActivitiesPage> {
  List<DevelopmentalResourceOverview>? allResourceOverviews;
  List<DevelopmentalResourceOverview>? socialResourceOverviews;
  List<DevelopmentalResourceOverview>? languageResourceOverviews;
  List<DevelopmentalResourceOverview>? cognitiveResourceOverviews;
  List<DevelopmentalResourceOverview>? movementResourceOverviews;

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
                allResourceOverviews != null && widget.activeChild != null
                    ? ResourcesSection(
                        activeChild: widget.activeChild!,
                        allResourceOverviews: socialResourceOverviews!,
                      )
                    : const Center(
                        child: CircularProgressIndicator(),
                      ),
                allResourceOverviews != null && widget.activeChild != null
                    ? ResourcesSection(
                        activeChild: widget.activeChild!,
                        allResourceOverviews: languageResourceOverviews!,
                      )
                    : const Center(
                        child: CircularProgressIndicator(),
                      ),
                allResourceOverviews != null && widget.activeChild != null
                    ? ResourcesSection(
                        activeChild: widget.activeChild!,
                        allResourceOverviews: cognitiveResourceOverviews!,
                      )
                    : const Center(
                        child: CircularProgressIndicator(),
                      ),
                allResourceOverviews != null && widget.activeChild != null
                    ? ResourcesSection(
                        activeChild: widget.activeChild!,
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
