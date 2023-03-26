import 'package:flutter/material.dart';
import '../components/custom_list_item.dart';
import '../models/doctors.dart';

class BehaviorDictionaryPageData {
  static List<CustomListItem> listItems = [
    CustomListItem(
      leading: Image.network(
        'https://thumbs.dreamstime.com/b/wood-texture-3753136.jpg',
        width: 56,
        height: 56,
      ),
      titleData: 'Title 1',
      subtitleData: 'Lorem',
    ),
    CustomListItem(
      leading: Image.network(
        'https://thumbs.dreamstime.com/b/wood-texture-3753136.jpg',
        width: 56,
        height: 56,
      ),
      titleData: 'Title 2',
      subtitleData: 'Ipsum',
    ),
    CustomListItem(
      leading: Image.network(
        'https://thumbs.dreamstime.com/b/wood-texture-3753136.jpg',
        width: 56,
        height: 56,
      ),
      titleData: 'Title 3',
      subtitleData: 'Dolor',
    ),
    CustomListItem(
      leading: Image.network(
        'https://thumbs.dreamstime.com/b/wood-texture-3753136.jpg',
        width: 56,
        height: 56,
      ),
      titleData: 'Title 4',
      subtitleData: 'Sit',
    ),
    CustomListItem(
      leading: Image.network(
        'https://thumbs.dreamstime.com/b/wood-texture-3753136.jpg',
        width: 56,
        height: 56,
      ),
      titleData: 'Title 5',
      subtitleData: 'Eth',
    ),
  ];
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
