import 'package:asdigi/screens/answer_milestones_checklist.dart';
import 'package:flutter/material.dart';

import '../components/milestone_checklist_section.dart';
import '../models/child.dart';
import '../models/milestone.dart';
import '../temp/temp_data.dart';
import 'milestones_overview.dart';

class MilestonesChecklistOverviewPage extends StatefulWidget {
  const MilestonesChecklistOverviewPage({super.key});

  @override
  State<MilestonesChecklistOverviewPage> createState() =>
      _MilestonesChecklistOverviewPageState();
}

class _MilestonesChecklistOverviewPageState
    extends State<MilestonesChecklistOverviewPage>
    with SingleTickerProviderStateMixin {
  List<MilestoneChecklistItem>? allMilestones;
  List<MilestoneChecklistItem>? socialMilestones;
  List<MilestoneChecklistItem>? languageMilestones;
  List<MilestoneChecklistItem>? cognitiveMilestones;
  List<MilestoneChecklistItem>? movementMilestones;
  Child? activeChild;

  late TabController tabController;
  late ScrollController scrollController;
  Key _listKey = UniqueKey();

  void fetchActiveChild() async {
    activeChild = await Child.getActiveChild();
    setState(() {});
  }

  void fetchMilestones() async {
    allMilestones = await MilestoneChecklistItem.getAllFromFirestore();
    loadAllMilestones(allMilestones!);
  }

  void loadAllMilestones(List<MilestoneChecklistItem> allMilestones) {
    socialMilestones = allMilestones
        .where((element) =>
            element.milestoneCategory == MilestoneOverviewItem.social)
        .toList();
    languageMilestones = allMilestones
        .where((element) =>
            element.milestoneCategory == MilestoneOverviewItem.language)
        .toList();
    cognitiveMilestones = allMilestones
        .where((element) =>
            element.milestoneCategory == MilestoneOverviewItem.cognitive)
        .toList();
    movementMilestones = allMilestones
        .where((element) =>
            element.milestoneCategory == MilestoneOverviewItem.movement)
        .toList();
    setState(() {});
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  void _updateListKey() {
    _listKey = UniqueKey(); // generate a new key
    setState(() {}); // rebuild the widget
  }

  @override
  void initState() {
    super.initState();
    fetchActiveChild();
    fetchMilestones();
    tabController = TabController(length: 4, vsync: this);
    scrollController = ScrollController();
    tabController.addListener(() {
      if (tabController.indexIsChanging && scrollController.offset > 132) {
        scrollController.animateTo(132,
            duration: const Duration(milliseconds: 300), curve: Curves.ease);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      controller: scrollController,
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        SliverAppBar(
          floating: true,
          pinned: true,
          toolbarHeight: 130,
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text((activeChild == null)
                      ? '...'
                      : '${activeChild!.name} (${Child.getAgeStringInYears(activeChild!.ageInMonths)})'),
                  const Text('Milestones Checklist'),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MilestonesOverviewPage(),
                        ),
                      );
                    },
                    child: const Text(
                      'See all Developmental Milestones',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              IconButton(
                onPressed: () async {
                  if (allMilestones != null) {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AnswerMilestoneChecklistPage(
                          allMilestones: allMilestones!,
                          onSubmit: () {
                            MilestoneChecklistItem.updateChecklist(
                                allMilestones!);
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ).then((value) => _updateListKey());
                  }
                },
                icon: const Icon(Icons.edit),
                tooltip: 'Edit',
              ),
            ],
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: TabBar(
              isScrollable: true,
              controller: tabController,
              tabs: const [
                Tab(
                  text: 'Social',
                ),
                Tab(
                  text: 'Language',
                ),
                Tab(
                  text: 'Cognitive',
                ),
                Tab(
                  text: 'Movement',
                )
              ],
              indicatorSize: TabBarIndicatorSize.tab,
            ),
          ),
        ),
      ],
      body: TabBarView(
        key: _listKey,
        controller: tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          (socialMilestones != null)
              ? MilestoneChecklistSection(
                  socialMilestones!,
                  readOnly: true,
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
          (languageMilestones != null)
              ? MilestoneChecklistSection(
                  languageMilestones!,
                  readOnly: true,
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
          (cognitiveMilestones != null)
              ? MilestoneChecklistSection(
                  cognitiveMilestones!,
                  readOnly: true,
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
          (movementMilestones != null)
              ? MilestoneChecklistSection(
                  movementMilestones!,
                  readOnly: true,
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        ],
      ),
    );
  }
}
