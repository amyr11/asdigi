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

class _MilestonesChecklistPageState extends State<MilestonesChecklistPage> {
  late List<MilestoneChecklistItem> socialMilestones;
  late List<MilestoneChecklistItem> languageMilestones;
  late List<MilestoneChecklistItem> cognitiveMilestones;
  late List<MilestoneChecklistItem> movementMilestones;

  @override
  void initState() {
    super.initState();
    socialMilestones = MilestonesCheclistPageData().socialMilestones;
    languageMilestones = MilestonesCheclistPageData().languageMilestones;
    cognitiveMilestones = MilestonesCheclistPageData().cognitiveMilestones;
    movementMilestones = MilestonesCheclistPageData().movementMilestones;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: NestedScrollView(
        physics: NeverScrollableScrollPhysics(),
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            floating: true,
            snap: true,
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
            bottom: const PreferredSize(
              preferredSize: Size.fromHeight(50),
              child: TabBar(
                isScrollable: true,
                tabs: [
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
          children: [
            MilestoneCheclistSection(socialMilestones, readOnly: true),
            MilestoneCheclistSection(languageMilestones, readOnly: true),
            MilestoneCheclistSection(cognitiveMilestones, readOnly: true),
            MilestoneCheclistSection(movementMilestones, readOnly: true),
          ],
        ),
      ),
    );
  }
}
