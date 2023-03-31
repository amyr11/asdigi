import 'package:flutter/material.dart';

import '../models/milestone.dart';
import 'milestone_overview_item_card.dart';

class MilestoneOverviewSection extends StatelessWidget {
  final List<MilestoneOverviewItem> milestones;

  const MilestoneOverviewSection(this.milestones, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: milestones.length,
        padding: const EdgeInsets.symmetric(vertical: 20),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: MilestoneOverviewItemCard(
              imageURL: milestones[index].imageURL,
              title: milestones[index].title,
            ),
          );
        },
      ),
    );
  }
}
