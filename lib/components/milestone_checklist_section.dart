import 'package:flutter/material.dart';

import '../models/milestone.dart';
import 'milestone_checklist_item_card.dart';

class MilestoneCheclistSection extends StatefulWidget {
  final List<MilestoneChecklistItem> milestones;

  const MilestoneCheclistSection(this.milestones, {super.key});

  @override
  State<MilestoneCheclistSection> createState() =>
      _MilestoneCheclistSectionState();
}

class _MilestoneCheclistSectionState extends State<MilestoneCheclistSection>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: widget.milestones.length,
        padding: const EdgeInsets.symmetric(vertical: 20),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: MilestoneCheclistItemCard(
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
    ;
  }
}
