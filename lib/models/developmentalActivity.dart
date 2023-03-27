import 'package:flutter/material.dart';

class DevelopmentalActivity {
  final Image backgroundImage;
  final String title;
  final String category;
  final String description;
  final String milestone;
  final bool isPinned;

  DevelopmentalActivity(this.backgroundImage, this.title, this.category,
      this.description, this.milestone, this.isPinned);
}
