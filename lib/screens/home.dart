import 'package:flutter/material.dart';
import '../components/app_bar_profile.dart';
import '../components/custom_doctor_item.dart';
import '../components/custom_nav_bar.dart';

List<String> places = <String>['Manila', 'Mandaluyong', 'Makati', 'Marikina'];
List<String> occupations = <String>[
  'Developmental Pediatrician',
  'Physical Therapist',
  'Speech Therapist',
  'Other Therapist'
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
                              SizedBox(),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black),
                                      borderRadius: BorderRadius.circular(8)),
                                  child: DropdownButtonFormField(
                                    style:
                                        Theme.of(context).textTheme.labelSmall,
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
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: ListView.separated(
                            itemCount: 5,
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return SizedBox(
                                  height:
                                      10); // set the height of the separator here
                            },
                            itemBuilder: (BuildContext context, int index) {
                              return CustomDoctorItem(
                                  pfp:
                                      'https://images.theconversation.com/files/304957/original/file-20191203-66986-im7o5.jpg?ixlib=rb-1.1.0&q=45&auto=format&w=1200&h=1200.0&fit=crop',
                                  docName: 'Dr. Heart Marcial',
                                  docOccupation: 'Developmental Pediatrician',
                                  description:
                                      'Specializes in speech therapy, helping individuals with a wide range of speech and language issues',
                                  hospitalName: 'Ospital ng Sampaloc',
                                  address: 'España Blvd., Sampaloc, Manila',
                                  trunkLine: 'Trunk line: (02) 781-4201');
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
                            itemCount: 5,
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

class CustomFinancialItem extends StatelessWidget {
  const CustomFinancialItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        onTap: () {},
        leading: Image.network(
          'https://play-lh.googleusercontent.com/b60f8bzdLdXPgmJ7oAJyLTneTfDnRTimi4hXHWtLWYlJpyhLCibhKaBI5oMU6GQ1xg',
        ),
        title: Text(
          'Family and Community Welfare Program (FCWP)',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        subtitle: Text(
          'Thie program aims to help disadvantaged families improve their ability to identify needs',
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ),
    );
  }
}
