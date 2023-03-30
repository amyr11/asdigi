import 'package:asdigi/models/milestone.dart';
import 'package:flutter/material.dart';

class EditMilestoneCheclistPage extends StatefulWidget {
  final List<MilestoneChecklistItem> socialMilestones;
  final List<MilestoneChecklistItem> languageMilestones;
  final List<MilestoneChecklistItem> cognitiveMilestones;
  final List<MilestoneChecklistItem> movementMilestones;

  const EditMilestoneCheclistPage({
    super.key,
    required this.socialMilestones,
    required this.languageMilestones,
    required this.cognitiveMilestones,
    required this.movementMilestones,
  });

  @override
  State<EditMilestoneCheclistPage> createState() =>
      _EditMilestoneCheclistPageState();
}

class _EditMilestoneCheclistPageState extends State<EditMilestoneCheclistPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Milestone Checklist'),
      ),
      body: const Center(
        child: Text('Edit Milestone Checklist'),
      ),
    );
  }
}
