import 'package:asdigi/screens/edit_milestones_checklist.dart';
import 'package:flutter/material.dart';

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
  Key _listKey = UniqueKey();

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
    socialMilestones =
        MilestonesChecklistPageData().generateDummyData('Social');
    languageMilestones =
        MilestonesChecklistPageData().generateDummyData('Language');
    cognitiveMilestones =
        MilestonesChecklistPageData().generateDummyData('Cognitive');
    movementMilestones =
        MilestonesChecklistPageData().generateDummyData('Movement');
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
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditMilestoneCheclistPage(
                        socialMilestones: socialMilestones,
                        languageMilestones: languageMilestones,
                        cognitiveMilestones: cognitiveMilestones,
                        movementMilestones: movementMilestones,
                      ),
                    ),
                  ).then((value) => _updateListKey());
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
          MilestoneChecklistSection(
            socialMilestones,
            readOnly: true,
          ),
          MilestoneChecklistSection(
            languageMilestones,
            readOnly: true,
          ),
          MilestoneChecklistSection(
            cognitiveMilestones,
            readOnly: true,
          ),
          MilestoneChecklistSection(
            movementMilestones,
            readOnly: true,
          ),
        ],
      ),
    );
  }
}
