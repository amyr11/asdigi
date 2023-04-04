import 'dart:math';

import 'package:asdigi/models/milestone.dart';
import 'package:asdigi/temp/temp_markdown.dart';
import 'package:flutter/material.dart';
import '../models/behavior.dart';
import '../models/developmentalActivity.dart';
import '../models/doctors.dart';

class DevelopmentalActivitiesPageData {
  List<DevelopmentalActivity> generateDummyData() {
    return List.generate(
          10,
          (index) => DevelopmentalActivity(
            backgroundImage: Image.network(
                'https://cdn.pixabay.com/photo/2012/08/27/14/19/mountains-55067__340.png'),
            title: 'Activity Title',
            category: 'Activity',
            description:
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, ',
            milestone: 'Social',
            isPinned: index % 4 == 0 ? true : false,
            content: DevelopmentalActivitiesMarkdownData.dummyMarkdown,
          ),
        ) +
        List.generate(
          10,
          (index) => DevelopmentalActivity(
            backgroundImage: Image.network(
                'https://cdn.pixabay.com/photo/2012/08/27/14/19/mountains-55067__340.png'),
            title: 'Tip Title',
            category: 'Tips',
            description:
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, ',
            milestone: 'Social',
            isPinned: index % 4 == 0 ? true : false,
            content: DevelopmentalActivitiesMarkdownData.dummyMarkdown,
          ),
        );
  }
}
