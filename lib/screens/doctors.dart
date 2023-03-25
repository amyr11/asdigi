import 'package:flutter/material.dart';

import '../components/custom_doctor_item.dart';
import '../components/custom_dropdown.dart';
import '../components/custom_financial_item.dart';
import '../models/doctors.dart';

class DoctorsPage extends StatefulWidget {
  const DoctorsPage({super.key});

  @override
  State<DoctorsPage> createState() => _DoctorsPageState();
}

class _DoctorsPageState extends State<DoctorsPage> {
  List<Doctor> doctors = <Doctor>[
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

  List<String> places = [
    'Anywhere',
    'Manila',
    'Mandaluyong',
    'Makati',
    'Quezon',
    'Marikina'
  ];
  List<String> occupations = <String>[
    'All Doctors',
    'Developmental Pediatrician',
    'Speech Therapist',
    'Psychological Therapist',
    'Occupational Therapist',
  ];

  List<Doctor> filteredDoctors = [];
  String textValuePlaces = '';
  String textValueOccupation = '';

  @override
  void initState() {
    super.initState();

    textValuePlaces = places.first;
    textValueOccupation = occupations.first;

    setFilteredDoctors(textValuePlaces, textValueOccupation);
  }

  void setFilteredDoctors(String place, String occupation) {
    setState(() {
      if (place == places.first && occupation == occupations.first) {
        filteredDoctors = doctors;
      } else if (place == places.first) {
        filteredDoctors = doctors
            .where((Doctor doctor) => doctor.occupation.contains(occupation))
            .toList();
      } else if (occupation == occupations.first) {
        filteredDoctors = doctors
            .where((Doctor doctor) => doctor.address.contains(place))
            .toList();
      } else {
        filteredDoctors = doctors
            .where((Doctor doctor) =>
                doctor.address.contains(place) &&
                doctor.occupation.contains(occupation))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 0,
            bottom: const TabBar(
              tabs: [
                Tab(
                  text: 'Doctors',
                ),
                Tab(
                  text: 'Financial Aid',
                )
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Doctors/Therapists',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: CustomDropDown(
                              value: textValuePlaces,
                              list: places,
                              onChanged: (String? value) {
                                setState(
                                  () {
                                    textValuePlaces = value!;
                                    setFilteredDoctors(
                                        textValuePlaces, textValueOccupation);
                                  },
                                );
                              }),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: CustomDropDown(
                              value: textValueOccupation,
                              list: occupations,
                              onChanged: (String? value) {
                                setState(
                                  () {
                                    textValueOccupation = value!;
                                    setFilteredDoctors(
                                        textValuePlaces, textValueOccupation);
                                  },
                                );
                              }),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: filteredDoctors.length,
                        itemBuilder: (context, index) {
                          return CustomDoctorItem(
                            pfp: filteredDoctors[index].profilePic,
                            docName: filteredDoctors[index].name,
                            docOccupation: filteredDoctors[index].occupation,
                            description: filteredDoctors[index].jobDescription,
                            address: filteredDoctors[index].address,
                            trunkLine: filteredDoctors[index].trunkLine,
                            hospitalName: filteredDoctors[index].hospital,
                          );
                        },
                        shrinkWrap: true,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Text(
                        'Financial Assistance',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Text(
                        'Discover financial help and sponsorships',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ),
                    Expanded(
                      child: ListView.separated(
                        itemCount: 3,
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(
                              height:
                                  10); // set the height of the separator here
                        },
                        itemBuilder: (BuildContext context, int index) {
                          return CustomFinancialItem();
                        },
                        shrinkWrap: true,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
