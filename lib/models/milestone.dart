class MilestoneChecklistItem {
  final String imageURL;
  final String title;
  int status = -1;

  MilestoneChecklistItem({
    required this.imageURL,
    required this.title,
  });
}

class MilestoneOverviewItem {
  final String imageURL;
  final String title;

  MilestoneOverviewItem({
    required this.imageURL,
    required this.title,
  });
}
