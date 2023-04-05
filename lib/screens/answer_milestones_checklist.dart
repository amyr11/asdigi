import 'package:asdigi/models/milestone.dart';
import 'package:flutter/material.dart';
import 'package:easy_stepper/easy_stepper.dart';

import '../components/milestone_checklist_section.dart';

class AnswerMilestoneChecklistPage extends StatefulWidget {
  final List<MilestoneChecklistItem> allMilestones;
  final void Function() onSubmit;

  const AnswerMilestoneChecklistPage({
    super.key,
    required this.allMilestones,
    required this.onSubmit,
  });

  @override
  State<AnswerMilestoneChecklistPage> createState() =>
      _AnswerMilestoneChecklistPage();
}

class _AnswerMilestoneChecklistPage
    extends State<AnswerMilestoneChecklistPage> {
  late int activeStep;
  late List<EasyStep> steps;
  late PageController pageController;
  late List<List<MilestoneChecklistItem>> allMilestonesCategory;
  late List<MilestoneChecklistItem> socialMilestones;
  late List<MilestoneChecklistItem> languageMilestones;
  late List<MilestoneChecklistItem> cognitiveMilestones;
  late List<MilestoneChecklistItem> movementMilestones;
  String nextButtonString = 'Next';

  void loadAllMilestones(List<MilestoneChecklistItem> allMilestones) {
    socialMilestones = allMilestones
        .where((element) =>
            element.milestoneCategory == MilestoneOverviewItem.social)
        .toList();
    languageMilestones = allMilestones
        .where((element) =>
            element.milestoneCategory == MilestoneOverviewItem.language)
        .toList();
    cognitiveMilestones = allMilestones
        .where((element) =>
            element.milestoneCategory == MilestoneOverviewItem.cognitive)
        .toList();
    movementMilestones = allMilestones
        .where((element) =>
            element.milestoneCategory == MilestoneOverviewItem.movement)
        .toList();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadAllMilestones(widget.allMilestones);
    allMilestonesCategory = [
      socialMilestones,
      languageMilestones,
      cognitiveMilestones,
      movementMilestones,
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
      int noStatusCount = allMilestonesCategory[step - 1]
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
    setState(() {
      if (step >= 0 && step < steps.length) {
        activeStep = step;
        pageController.animateToPage(
          step,
          duration: const Duration(milliseconds: 300),
          curve: Curves.ease,
        );
      }
      if (activeStep == steps.length - 1) {
        setState(() {
          nextButtonString = 'Submit';
        });
      } else {
        setState(() {
          nextButtonString = 'Next';
        });
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
                  MilestoneChecklistSection(allMilestonesCategory[index]),
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
                    onPressed: () {
                      if (activeStep < steps.length - 1) {
                        setActiveStep(activeStep + 1);
                      } else {
                        widget.onSubmit();
                      }
                    },
                    child: Text(nextButtonString),
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
