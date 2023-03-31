import 'dart:math';

import 'package:asdigi/models/milestone.dart';
import 'package:asdigi/temp/temp_markdown.dart';
import 'package:flutter/material.dart';
import '../models/behavior.dart';
import '../models/doctors.dart';

class MilestonesChecklistPageData {
  List<MilestoneChecklistItem> generateDummyData(String name) {
    return List.generate(
      3,
      (index) => MilestoneChecklistItem(
        title: '$name $index',
        imageURL:
            'https://cms-tc.pbskids.org/parents/expert-tips-and-advice/helping-young-children-learn-to-make-friends-hero.jpg',
      ),
    );
  }
}

class MilestonesOverviewPageData {
  List<MilestoneOverviewItem> generateDummyData(String name) {
    return List.generate(
      3,
      (index) => MilestoneOverviewItem(
        title: '$name $index',
        imageURL:
            'https://cms-tc.pbskids.org/parents/expert-tips-and-advice/helping-young-children-learn-to-make-friends-hero.jpg',
      ),
    );
  }
}

class BehaviorDictionaryPageData {
  static List<Behavior> listItems = List.filled(
      20,
      Behavior(
        image: BehaviorMarkdownData.image,
        title: BehaviorMarkdownData.title,
        description: BehaviorMarkdownData.description,
        overViewMarkdown: BehaviorMarkdownData.overViewMarkdown,
        howToAddressMarkdown: BehaviorMarkdownData.howToAddressMarkdown,
      ));
}

class DoctorsPageData {
  static List<Doctor> doctors = <Doctor>[
    Doctor(
        Image.network(
            'https://img.freepik.com/free-photo/attractive-young-male-nutriologist-lab-coat-smiling-against-white-background_662251-2960.jpg'),
        'Heart Marcial',
        'Developmental Pediatrician',
        'Specializes in speech therapy, helping individuals with a wide range of speech and language issues',
        'Ospital ng Sampaloc',
        'España Blvd., Sampaloc, Manila',
        'Trunkline: 827495'),
    Doctor(
        Image.network(
            'https://img.freepik.com/free-photo/beautiful-young-female-doctor-looking-camera-office_1301-7807.jpg'),
        'Amy Francisco',
        'Speech Therapist',
        'Talks to children who can not',
        'Ospital ng Mandaluyong',
        'Mandaluyong',
        'Trunkline: 294867'),
    Doctor(
        Image.network(
            'https://images.unsplash.com/photo-1612349317150-e413f6a5b16d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8ZG9jdG9yfGVufDB8fDB8fA%3D%3D&w=1000&q=80'),
        'Karl Malaga',
        'Psychological Therapist',
        'Talks to you and gives you advice for life',
        'St Luke\'s Medical Center',
        'Quezon City',
        'Trunkline: 294867'),
    Doctor(
        Image.network(
            'https://upload.wikimedia.org/wikipedia/en/5/53/Greys-Anatomy-Season-7-Promo-9.jpg'),
        'Eliza Lim',
        'Occupational Therapist',
        'Gives advice in movement of children',
        'Marikina Valley Medical Center',
        'Marikina City',
        'Trunkline: 294867'),
  ];

  static List<String> places = [
    'Anywhere',
    'Manila',
    'Mandaluyong',
    'Makati',
    'Quezon',
    'Marikina'
  ];
  static List<String> occupations = <String>[
    'All Doctors',
    'Developmental Pediatrician',
    'Speech Therapist',
    'Psychological Therapist',
    'Occupational Therapist',
  ];
}
