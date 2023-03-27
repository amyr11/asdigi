import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../components/custom_material_item.dart';
import '../components/custom_reccomendation_item.dart';
import '../models/developmentalActivity.dart';

class ActivitiesPage extends StatefulWidget {
  const ActivitiesPage({super.key});

  @override
  State<ActivitiesPage> createState() => _ActivitiesPageState();
}

enum materialFilter { Activities, Tips }

List<DevelopmentalActivity> allActivities = [
  DevelopmentalActivity(
    Image.network(
        'https://cdn.pixabay.com/photo/2012/08/27/14/19/mountains-55067__340.png'),
    'Title 1',
    'Activity',
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, ',
    'Social',
    false,
  ),
  DevelopmentalActivity(
    Image.network(
        'https://cdn.pixabay.com/photo/2012/08/27/14/19/mountains-55067__340.png'),
    'Title 2',
    'Tip',
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, ',
    'Cognitive',
    false,
  ),
  DevelopmentalActivity(
    Image.network(
        'https://cdn.pixabay.com/photo/2012/08/27/14/19/mountains-55067__340.png'),
    'Title 3',
    'Activity',
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, ',
    'Movement',
    true,
  ),
  DevelopmentalActivity(
    Image.network(
        'https://cdn.pixabay.com/photo/2012/08/27/14/19/mountains-55067__340.png'),
    'Title 4',
    'Tip',
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, ',
    'Language',
    true,
  ),
  DevelopmentalActivity(
    Image.network(
        'https://cdn.pixabay.com/photo/2012/08/27/14/19/mountains-55067__340.png'),
    'Title 5',
    'Activity',
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, ',
    'Movement',
    false,
  ),
];

List<DevelopmentalActivity> pinnedList =
    allActivities.where((activity) => activity.isPinned).toList();

class _ActivitiesPageState extends State<ActivitiesPage> {
  final List<String> _filters = <String>[];
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        child: DefaultTabController(
          length: 4,
          child: Scaffold(
            appBar: AppBar(
              toolbarHeight: 0,
              bottom: const TabBar(
                isScrollable: true,
                tabs: [
                  Tab(
                    child: Text(
                      'Social',
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Language',
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Cognitive',
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Movement',
                    ),
                  ),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 20),
                        child: Text(
                          'Recommended',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                      SizedBox(
                        height: 350,
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          scrollDirection: Axis.horizontal,
                          itemCount: allActivities.length,
                          itemBuilder: (context, index) {
                            return CustomRecommendationItem(
                              backgroundImage:
                                  allActivities[index].backgroundImage,
                              title: allActivities[index].title,
                              category: allActivities[index].category,
                              description: allActivities[index].description,
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Visibility(
                        visible: pinnedList.isNotEmpty,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                'Pinned',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ),
                            ListView.separated(
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: pinnedList.length,
                              separatorBuilder: (context, index) {
                                return const Divider();
                              },
                              itemBuilder: (context, index) {
                                return CustomMaterialItem(
                                  backgroundImage:
                                      pinnedList[index].backgroundImage,
                                  title: pinnedList[index].title,
                                  category: pinnedList[index].category,
                                  description: pinnedList[index].description,
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'All Materials',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: materialFilter.values
                                  .map((materialFilter filter) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: FilterChip(
                                    label: Text(filter.name),
                                    selected: !_filters.contains(filter.name),
                                    onSelected: (bool value) {
                                      setState(() {
                                        if (!value) {
                                          if (!_filters.contains(filter.name)) {
                                            _filters.add(filter.name);
                                          }
                                        } else {
                                          _filters.removeWhere((String name) {
                                            return name == filter.name;
                                          });
                                        }
                                      });
                                    },
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                      ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: allActivities.length,
                        separatorBuilder: (context, index) {
                          return const Divider();
                        },
                        itemBuilder: (context, index) {
                          return CustomMaterialItem(
                            backgroundImage:
                                allActivities[index].backgroundImage,
                            title: allActivities[index].title,
                            category: allActivities[index].category,
                            description: allActivities[index].description,
                          );
                        },
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
