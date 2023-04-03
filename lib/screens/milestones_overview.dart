import 'package:flutter/material.dart';

import '../components/custom_dropdown.dart';
import '../components/milestone_overview_section.dart';
import '../models/milestone.dart';

class MilestonesOverviewPage extends StatefulWidget {
  const MilestonesOverviewPage({super.key});

  @override
  State<MilestonesOverviewPage> createState() => _MilestonesOverviewPageState();
}

class _MilestonesOverviewPageState extends State<MilestonesOverviewPage>
    with SingleTickerProviderStateMixin {
  List<MilestoneOverviewItem>? allMilestones;
  List<MilestoneOverviewItem>? socialMilestones;
  List<MilestoneOverviewItem>? languageMilestones;
  List<MilestoneOverviewItem>? cognitiveMilestones;
  List<MilestoneOverviewItem>? movementMilestones;
  List<int>? ages;
  List<String>? agesString;
  String? dropdownAge;
  int? currentAge;

  late TabController tabController;
  late ScrollController scrollController;

  void fetchMilestones() async {
    allMilestones =
        await MilestoneOverviewItem.getAllFromFirestore().then((value) {
      loadAges(value);
      return value;
    });
    setState(() {});
  }

  void loadAllMilestones(int? age) {
    if (allMilestones != null && age != null) {
      socialMilestones = allMilestones!
          .where((element) =>
              element.milestoneCategory == MilestoneOverviewItem.social &&
              element.age == age)
          .toList();
      languageMilestones = allMilestones!
          .where((element) =>
              element.milestoneCategory == MilestoneOverviewItem.language &&
              element.age == age)
          .toList();
      cognitiveMilestones = allMilestones!
          .where((element) =>
              element.milestoneCategory == MilestoneOverviewItem.cognitive &&
              element.age == age)
          .toList();
      movementMilestones = allMilestones!
          .where((element) =>
              element.milestoneCategory == MilestoneOverviewItem.movement &&
              element.age == age)
          .toList();
    }
    setState(() {});
  }

  void loadAges(List<MilestoneOverviewItem> allMilestones) {
    // get the unique ages from milestones
    ages = <int>{
      ...allMilestones.map((e) => e.age),
    }.toList();
    ages!.sort();
    agesString = ages!.map((e) => getAgeString(e)).toList();
    updateAge(ages!.first);
    setState(() {});
  }

  String getAgeString(int age) {
    String word = '';
    bool isYear = age % 12 == 0;
    if (isYear) {
      age = age ~/ 12;
      word = age > 1 ? 'years' : 'year';
    } else {
      word = age > 1 ? 'months' : 'month';
    }
    return '$age $word old';
  }

  void updateAge(int age) {
    dropdownAge = getAgeString(age);
    currentAge = age;
    setState(() {});
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    fetchMilestones();
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
    loadAllMilestones(currentAge);
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
                    child: agesString != null
                        ? CustomDropDown(
                            outlined: false,
                            value: dropdownAge!,
                            list: agesString!,
                            onChanged: (String? value) {
                              setState(() {
                                updateAge(ages![agesString!.indexOf(value!)]);
                              });
                            },
                          )
                        : const Center(
                            child: CircularProgressIndicator(),
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
            socialMilestones != null
                ? MilestoneOverviewSection(socialMilestones!)
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
            languageMilestones != null
                ? MilestoneOverviewSection(languageMilestones!)
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
            cognitiveMilestones != null
                ? MilestoneOverviewSection(cognitiveMilestones!)
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
            movementMilestones != null
                ? MilestoneOverviewSection(movementMilestones!)
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
          ],
        ),
      ),
    );
  }
}
