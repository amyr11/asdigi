import 'package:flutter/material.dart';
import '../components/custom_material_item.dart';
import '../components/custom_reccomendation_item.dart';
import '../models/developmentalActivity.dart';
import '../temp/temp_data.dart';
import 'activity_content.dart';

class ActivitiesPage extends StatefulWidget {
  const ActivitiesPage({super.key});

  @override
  State<ActivitiesPage> createState() => _ActivitiesPageState();
}

late List<DevelopmentalActivity> allActivities;

class _ActivitiesPageState extends State<ActivitiesPage> {
  final List<String> _filters = <String>['Activity', 'Tips'];
  Key _activitiesKey = UniqueKey();

  void _updateActivitiesKey() {
    _activitiesKey = UniqueKey(); // generate a new key
    setState(() {}); // rebuild the widget
  }

  @override
  void initState() {
    super.initState();
    allActivities = DevelopmentalActivitiesPageData().generateDummyData();
  }

  void goToActivityContentPage(DevelopmentalActivity activity) async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ActivityContentPage(activity);
    })).then((value) => _updateActivitiesKey());
  }

  @override
  Widget build(BuildContext context) {
    List<DevelopmentalActivity> pinnedList =
        allActivities.where((activity) => activity.isPinned).toList();
    List<DevelopmentalActivity> recommendedActivities =
        allActivities.sublist(0, 3);

    return Container(
        key: _activitiesKey,
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
                          itemCount: recommendedActivities.length,
                          itemBuilder: (context, index) {
                            return CustomRecommendationItem(
                              backgroundImage:
                                  recommendedActivities[index].backgroundImage,
                              title: recommendedActivities[index].title,
                              category: recommendedActivities[index].category,
                              description:
                                  recommendedActivities[index].description,
                              onTap: () {
                                goToActivityContentPage(
                                    recommendedActivities[index]);
                              },
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 25,
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
                            const SizedBox(
                              height: 20,
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
                                  onTap: () {
                                    goToActivityContentPage(pinnedList[index]);
                                  },
                                );
                              },
                            ),
                            const SizedBox(height: 25),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'All Materials',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(height: 5),
                            Row(children: [
                              FilterChip(
                                label: const Text('Activity'),
                                selected: _filters.contains('Activity'),
                                onSelected: (selected) {
                                  setState(() {
                                    if (selected) {
                                      _filters.add('Activity');
                                    } else if (_filters.length == 2) {
                                      _filters.remove('Activity');
                                    }
                                  });
                                },
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              FilterChip(
                                label: const Text('Tips'),
                                selected: _filters.contains('Tips'),
                                onSelected: (selected) {
                                  setState(() {
                                    if (selected) {
                                      _filters.add('Tips');
                                    } else if (_filters.length == 2) {
                                      _filters.remove('Tips');
                                    }
                                  });
                                },
                              )
                            ]),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: allActivities
                            .where((activity) =>
                                _filters.contains(activity.category))
                            .length,
                        separatorBuilder: (context, index) {
                          return const Divider();
                        },
                        itemBuilder: (context, index) {
                          final filtered = allActivities
                              .where((activity) =>
                                  _filters.contains(activity.category))
                              .toList();
                          return CustomMaterialItem(
                            backgroundImage: filtered[index].backgroundImage,
                            title: filtered[index].title,
                            category: filtered[index].category,
                            description: filtered[index].description,
                            onTap: () {
                              goToActivityContentPage(filtered[index]);
                            },
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
