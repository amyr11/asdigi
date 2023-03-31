import 'package:flutter/material.dart';

class DevelopmentalActivity {
  Image backgroundImage;
  String title;
  String category;
  String description;
  String milestone;
  bool isPinned;
  String content;

  DevelopmentalActivity({
    required this.backgroundImage,
    required this.title,
    required this.category,
    required this.description,
    required this.milestone,
    required this.isPinned,
    required this.content,
  });
}
