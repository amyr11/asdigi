import 'package:flutter/material.dart';

import '../models/milestone.dart';
import 'milestone_checklist_item_card.dart';

class MilestoneChecklistSection extends StatefulWidget {
  final List<MilestoneChecklistItem> milestones;

  final bool readOnly;
  final ScrollPhysics? physics;

  const MilestoneChecklistSection(
    this.milestones, {
    super.key,
    this.readOnly = false,
    this.physics,
  });

  @override
  State<MilestoneChecklistSection> createState() =>
      _MilestoneChecklistSectionState();
}

class _MilestoneChecklistSectionState extends State<MilestoneChecklistSection> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.builder(
        shrinkWrap: true,
        physics: widget.physics,
        itemCount: widget.milestones.length,
        padding: const EdgeInsets.symmetric(vertical: 20),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: MilestoneCheclistItemCard(
              enabled: !widget.readOnly,
              imageURL: widget.milestones[index].imageURL,
              title: widget.milestones[index].title,
              intialSelected: widget.milestones[index].status,
              onChangeSelected: (value) {
                setState(() {
                  widget.milestones[index].status = value;
                });
              },
            ),
          );
        },
      ),
    );
  }
}
