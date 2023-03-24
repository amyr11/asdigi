import 'package:flutter/material.dart';
import '../components/app_bar_profile.dart';
import '../components/custom_doctor_item.dart';
import '../components/custom_financial_item.dart';
import '../components/custom_nav_bar.dart';
import '../models/doctors.dart';

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
  'Location',
  'Manila',
  'Mandaluyong',
  'Makati',
  'Quezon',
  'Marikina'
];
List<String> occupations = <String>[
  'Type',
  'Developmental Pedia',
  'Speech Therapist',
  'Psychological Therapist',
  'Occupational Therapist',
  'Sample Therapist'
];

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  int currentPageIndex = 4;
  String textValuePlaces = places.first;
  String textValueOccupation = occupations.first;

  @override
  Widget build(BuildContext context) {
    // for (Doctor doctor in doctors) {
    //   places.add(doctor.address);
    // }
    // for (Doctor doctor in doctors) {
    //   occupations.add(doctor.occupation);
    // }
    return Scaffold(
      appBar: AppBarWithProfile(context),
      bottomNavigationBar: CustomNavBar(
        currentPageIndex: currentPageIndex,
        onDestinationSelected: (int indexSelected) {
          setState(() {
            currentPageIndex = indexSelected;
          });
        },
      ),
      body: <Widget>[
        Container(
          alignment: Alignment.center,
          child: Text(
            'Page 1',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        Container(
          alignment: Alignment.center,
          child: Text(
            'Page 2',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        Container(
          alignment: Alignment.center,
          child: Text(
            'Page 3',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        Container(
          child: Text(
            'Page 4',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        Container(
          alignment: Alignment.center,
          child: DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                title: const TabBar(
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
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Text(
                            'Doctors/Therapists',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black),
                                      borderRadius: BorderRadius.circular(8)),
                                  child: DropdownButtonFormField<String>(
                                    alignment: Alignment.center,
                                    style:
                                        Theme.of(context).textTheme.labelSmall,
                                    value: textValuePlaces,
                                    items: places.map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    onChanged: (String? value) {
                                      // This is called when the user selects an item.
                                      setState(() {
                                        textValuePlaces = value!;
                                      });
                                    },
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black),
                                        borderRadius: BorderRadius.circular(8)),
                                    child: DropdownButtonFormField(
                                      alignment: Alignment.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall,
                                      value: textValueOccupation,
                                      items: occupations
                                          .map<DropdownMenuItem<String>>(
                                              (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                      onChanged: (String? value) {
                                        // This is called when the user selects an item.
                                        setState(() {
                                          textValueOccupation = value!;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: doctors.length,
                            itemBuilder: (context, index) {
                              // Filter doctors by occupation
                              if ((textValueOccupation == 'Type' &&
                                      textValuePlaces == 'Location') ||
                                  doctors[index]
                                      .occupation
                                      .contains(textValueOccupation) ||
                                  doctors[index]
                                      .address
                                      .contains(textValuePlaces)) {
                                return CustomDoctorItem(
                                  pfp: doctors[index].profilePic,
                                  docName: doctors[index].name,
                                  docOccupation: doctors[index].occupation,
                                  description: doctors[index].jobDescription,
                                  address: doctors[index].address,
                                  trunkLine: doctors[index].trunkLine,
                                  hospitalName: doctors[index].hospital,
                                );
                              } else {
                                return SizedBox.shrink();
                              }
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
                            separatorBuilder:
                                (BuildContext context, int index) {
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
        ),
      ][currentPageIndex],
    );
  }
}
