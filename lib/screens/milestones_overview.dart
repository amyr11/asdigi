import 'package:flutter/material.dart';

import '../components/custom_dropdown.dart';
import '../components/milestone_overview_section.dart';
import '../models/milestone.dart';
import '../temp/temp_data.dart';

class MilestonesOverviewPage extends StatefulWidget {
  const MilestonesOverviewPage({super.key});

  @override
  State<MilestonesOverviewPage> createState() => _MilestonesOverviewPageState();
}

class _MilestonesOverviewPageState extends State<MilestonesOverviewPage>
    with SingleTickerProviderStateMixin {
  late List<MilestoneOverviewItem> socialMilestones;
  late List<MilestoneOverviewItem> languageMilestones;
  late List<MilestoneOverviewItem> cognitiveMilestones;
  late List<MilestoneOverviewItem> movementMilestones;

  late TabController tabController;
  late ScrollController scrollController;
  late List<String> ages;
  late String dropdownAge;

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    ages = [
      '5 years old',
      '4 years old',
      '3 years old',
      '2 years old',
      '1 year old',
    ];
    dropdownAge = ages[0];
    socialMilestones = MilestonesOverviewPageData().generateDummyData('Social');
    languageMilestones =
        MilestonesOverviewPageData().generateDummyData('Language');
    cognitiveMilestones =
        MilestonesOverviewPageData().generateDummyData('Cognitive');
    movementMilestones =
        MilestonesOverviewPageData().generateDummyData('Movement');
    tabController = TabController(length: 4, vsync: this);
    scrollController = ScrollController();
    tabController.addListener(() {
      if (tabController.indexIsChanging && scrollController.offset > 62) {
        scrollController.animateTo(62,
            duration: const Duration(milliseconds: 300), curve: Curves.ease);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        controller: scrollController,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            floating: true,
            pinned: true,
            toolbarHeight: 60,
            title: const Text('Milestones Overview'),
            actions: [
              IconButton(
                icon: const Icon(Icons.info_outline),
                onPressed: () {},
              ),
            ],
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(100),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: CustomDropDown(
                      outlined: false,
                      value: dropdownAge,
                      list: ages,
                      onChanged: (String? value) {
                        setState(() {
                          dropdownAge = value!;
                          // TODO: Filter milestones based on age
                        });
                      },
                    ),
                  ),
                  TabBar(
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
                ],
              ),
            ),
          ),
        ],
        body: TabBarView(
          controller: tabController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            MilestoneOverviewSection(socialMilestones),
            MilestoneOverviewSection(languageMilestones),
            MilestoneOverviewSection(cognitiveMilestones),
            MilestoneOverviewSection(movementMilestones),
          ],
        ),
      ),
    );
  }
}
