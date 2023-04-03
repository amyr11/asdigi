import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../components/custom_doctor_item.dart';
import '../components/custom_dropdown.dart';
import '../components/custom_financial_item.dart';
import '../models/doctors.dart';
import '../temp/temp_data.dart';

class DoctorsPage extends StatefulWidget {
  const DoctorsPage({super.key});

  @override
  State<DoctorsPage> createState() => _DoctorsPageState();
}

class _DoctorsPageState extends State<DoctorsPage> {
  List<Doctor> filteredDoctors = [];
  String textValuePlaces = '';
  String textValueOccupation = '';

  @override
  void initState() {
    super.initState();

    textValuePlaces = DoctorsPageData.places.first;
    textValueOccupation = DoctorsPageData.occupations.first;

    setFilteredDoctors(textValuePlaces, textValueOccupation);
  }

  void setFilteredDoctors(String place, String occupation) {
    setState(() {
      if (place == DoctorsPageData.places.first &&
          occupation == DoctorsPageData.occupations.first) {
        filteredDoctors = DoctorsPageData.doctors;
      } else if (place == DoctorsPageData.places.first) {
        filteredDoctors = DoctorsPageData.doctors
            .where((Doctor doctor) => doctor.occupation.contains(occupation))
            .toList();
      } else if (occupation == DoctorsPageData.occupations.first) {
        filteredDoctors = DoctorsPageData.doctors
            .where((Doctor doctor) => doctor.address.contains(place))
            .toList();
      } else {
        filteredDoctors = DoctorsPageData.doctors
            .where((Doctor doctor) =>
                doctor.address.contains(place) &&
                doctor.occupation.contains(occupation))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            floating: true,
            pinned: true,
            title: const Text('Doctors/Therapists'),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(70),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: CustomDropDown(
                              value: textValuePlaces,
                              isExpanded: true,
                              list: DoctorsPageData.places,
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
                              isExpanded: true,
                              list: DoctorsPageData.occupations,
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
                  ],
                ),
              ),
            ),
          ),
        ];
      },
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView.builder(
          itemCount: filteredDoctors.length,
          itemBuilder: (context, index) {
            return CustomDoctorItem(
              docName: filteredDoctors[index].name,
              docOccupation: filteredDoctors[index].occupation,
              description: filteredDoctors[index].jobDescription,
              address: filteredDoctors[index].address,
              trunkLine: filteredDoctors[index].trunkLine,
              hospitalName: filteredDoctors[index].hospital,
              callNumber: () {
                // ignore: deprecated_member_use
                launch('tel:${filteredDoctors[index].trunkLine}');
              },
            );
          },
          shrinkWrap: true,
        ),
      ),
    );
  }
}

// Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const SizedBox(
//             height: 20,
//           ),
//           Text(
//             'Doctors/Therapists',
//             style: Theme.of(context).textTheme.titleLarge,
//           ),
//           const SizedBox(
//             height: 20,
//           ),
//           Row(
//             children: [
//               Expanded(
//                 child: CustomDropDown(
//                     value: textValuePlaces,
//                     isExpanded: true,
//                     list: DoctorsPageData.places,
//                     onChanged: (String? value) {
//                       setState(
//                         () {
//                           textValuePlaces = value!;
//                           setFilteredDoctors(
//                               textValuePlaces, textValueOccupation);
//                         },
//                       );
//                     }),
//               ),
//               const SizedBox(
//                 width: 10,
//               ),
//               Expanded(
//                 child: CustomDropDown(
//                     value: textValueOccupation,
//                     isExpanded: true,
//                     list: DoctorsPageData.occupations,
//                     onChanged: (String? value) {
//                       setState(
//                         () {
//                           textValueOccupation = value!;
//                           setFilteredDoctors(
//                               textValuePlaces, textValueOccupation);
//                         },
//                       );
//                     }),
//               ),
//             ],
//           ),
//           const SizedBox(
//             height: 20,
//           ),
    //       Expanded(
    //         child: ListView.builder(
    //           itemCount: filteredDoctors.length,
    //           itemBuilder: (context, index) {
    //             return CustomDoctorItem(
    //               pfp: filteredDoctors[index].profilePic,
    //               docName: filteredDoctors[index].name,
    //               docOccupation: filteredDoctors[index].occupation,
    //               description: filteredDoctors[index].jobDescription,
    //               address: filteredDoctors[index].address,
    //               trunkLine: filteredDoctors[index].trunkLine,
    //               hospitalName: filteredDoctors[index].hospital,
    //             );
    //           },
    //           shrinkWrap: true,
    //         ),
    //       )
    //     ],
    //   ),
    // )