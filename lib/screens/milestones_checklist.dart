import 'package:flutter/material.dart';

import '../components/milestone_checklist_item_card.dart';
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
  late TabController tabController;
  late List<MilestoneChecklistItem> socialMilestones;
  late List<MilestoneChecklistItem> languageMilestones;
  late List<MilestoneChecklistItem> cognitiveMilestones;
  late List<MilestoneChecklistItem> movementMilestones;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);

    socialMilestones = MilestonesCheclistPageData().socialMilestones;
    languageMilestones = MilestonesCheclistPageData().languageMilestones;
    cognitiveMilestones = MilestonesCheclistPageData().cognitiveMilestones;
    movementMilestones = MilestonesCheclistPageData().movementMilestones;
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            floating: true,
            snap: true,
            pinned: true,
            toolbarHeight: 130,
            title: Column(
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
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(50),
              child: TabBar(
                isScrollable: true,
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
                controller: tabController,
                indicatorSize: TabBarIndicatorSize.tab,
              ),
            ),
          ),
        ],
        body: TabBarView(
          controller: tabController,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: socialMilestones.length,
                padding: const EdgeInsets.symmetric(vertical: 20),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: MilestoneCheclistItemCard(
                      imageURL: socialMilestones[index].imageURL,
                      title: socialMilestones[index].title,
                      intialSelected: socialMilestones[index].status,
                      onChangeSelected: (value) {
                        setState(() {
                          socialMilestones[index].status = value;
                        });
                      },
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: languageMilestones.length,
                padding: const EdgeInsets.symmetric(vertical: 20),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: MilestoneCheclistItemCard(
                      imageURL: languageMilestones[index].imageURL,
                      title: languageMilestones[index].title,
                      intialSelected: languageMilestones[index].status,
                      onChangeSelected: (value) {
                        setState(() {
                          languageMilestones[index].status = value;
                        });
                      },
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: cognitiveMilestones.length,
                padding: const EdgeInsets.symmetric(vertical: 20),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: MilestoneCheclistItemCard(
                      imageURL: cognitiveMilestones[index].imageURL,
                      title: cognitiveMilestones[index].title,
                      intialSelected: cognitiveMilestones[index].status,
                      onChangeSelected: (value) {
                        setState(() {
                          cognitiveMilestones[index].status = value;
                        });
                      },
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: movementMilestones.length,
                padding: const EdgeInsets.symmetric(vertical: 20),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: MilestoneCheclistItemCard(
                      imageURL: movementMilestones[index].imageURL,
                      title: movementMilestones[index].title,
                      intialSelected: movementMilestones[index].status,
                      onChangeSelected: (value) {
                        setState(() {
                          movementMilestones[index].status = value;
                        });
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
