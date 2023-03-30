import 'package:asdigi/models/milestone.dart';
import 'package:flutter/material.dart';
import 'package:easy_stepper/easy_stepper.dart';

import '../components/milestone_checklist_section.dart';

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
  late int activeStep;
  late List<EasyStep> steps;
  late PageController pageController;
  late List<List<MilestoneChecklistItem>> allMilestones;

  @override
  void initState() {
    super.initState();
    allMilestones = [
      widget.socialMilestones,
      widget.languageMilestones,
      widget.cognitiveMilestones,
      widget.movementMilestones,
    ];
    pageController = PageController();
    activeStep = 0;
    steps = const [
      EasyStep(
        icon: Icon(Icons.people),
        title: 'Social',
      ),
      EasyStep(
        icon: Icon(Icons.language),
        title: 'Language',
      ),
      EasyStep(
        icon: Icon(Icons.brush),
        title: 'Cognitive',
      ),
      EasyStep(
        icon: Icon(Icons.directions_walk),
        title: 'Movement',
      ),
    ];
  }

  void setActiveStep(int step) {
    // TODO: Refactor
    if (step > activeStep) {
      int noStatusCount = allMilestones[step - 1]
          .where((element) => element.status == -1)
          .length;
      if (noStatusCount > 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Theme.of(context).colorScheme.errorContainer,
            content: Text(
              'Please select a status for all milestones in this section.',
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onErrorContainer),
            ),
          ),
        );
        return;
      }
    }
    if (step == steps.length) {
      Navigator.pop(context, allMilestones);
    }
    setState(() {
      if (step >= 0 && step < steps.length) {
        activeStep = step;
        pageController.animateToPage(
          step,
          duration: const Duration(milliseconds: 300),
          curve: Curves.ease,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Milestone Checklist'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(125),
          child: EasyStepper(
            showStepBorder: false,
            lineLength: 20,
            lineType: LineType.normal,
            lineColor: Theme.of(context).colorScheme.outlineVariant,
            stepRadius: 28,
            padding: 12,
            enableStepTapping: false,
            showLoadingAnimation: false,
            activeStep: activeStep,
            steps: steps,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              physics: const NeverScrollableScrollPhysics(),
              controller: pageController,
              itemBuilder: (context, index) =>
                  MilestoneChecklistSection(allMilestones[index]),
            ),
          ),
          SizedBox(
            height: 70,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  activeStep > 0
                      ? TextButton(
                          onPressed: () => setActiveStep(activeStep - 1),
                          child: const Text('Back'),
                        )
                      : const Spacer(),
                  const Spacer(),
                  TextButton(
                    onPressed: () => setActiveStep(activeStep + 1),
                    child: const Text('Next'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
