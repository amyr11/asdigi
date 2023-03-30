import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../components/milestone_checklist_item_card.dart';
import '../components/milestone_checklist_section.dart';
import '../models/milestone.dart';
import '../temp/temp_data.dart';

class MilestonesChecklistPage extends StatefulWidget {
  const MilestonesChecklistPage({super.key});

  @override
  State<MilestonesChecklistPage> createState() =>
      _MilestonesChecklistPageState();
}

class _MilestonesChecklistPageState extends State<MilestonesChecklistPage>
    with SingleTickerProviderStateMixin {
  late List<MilestoneChecklistItem> socialMilestones;
  late List<MilestoneChecklistItem> languageMilestones;
  late List<MilestoneChecklistItem> cognitiveMilestones;
  late List<MilestoneChecklistItem> movementMilestones;

  late TabController tabController;
  late ScrollController scrollController;

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
    scrollController = ScrollController();
    tabController.addListener(() {
      if (tabController.indexIsChanging) {
        scrollController.animateTo(132,
            duration: const Duration(milliseconds: 300), curve: Curves.ease);
      }
    });
    socialMilestones = MilestonesCheclistPageData().socialMilestones;
    languageMilestones = MilestonesCheclistPageData().languageMilestones;
    cognitiveMilestones = MilestonesCheclistPageData().cognitiveMilestones;
    movementMilestones = MilestonesCheclistPageData().movementMilestones;
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
                  const Text('Juan (5 years old)'),
                  const Text('Milestones Checklist'),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                    ),
                    onPressed: () {},
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
                onPressed: () {},
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
        controller: tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          MilestoneCheclistSection(socialMilestones, readOnly: true),
          MilestoneCheclistSection(languageMilestones, readOnly: true),
          MilestoneCheclistSection(cognitiveMilestones, readOnly: true),
          MilestoneCheclistSection(movementMilestones, readOnly: true),
        ],
      ),
    );
  }
}
