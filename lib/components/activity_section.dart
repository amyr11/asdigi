import 'package:flutter/material.dart';
import '../components/custom_material_item.dart';
import '../components/custom_reccomendation_item.dart';
import '../models/child.dart';
import '../models/developmental_resource.dart';
import '../screens/activity_content.dart';

class ResourcesSection extends StatefulWidget {
  final Child activeChild;
  final List<DevelopmentalResourceOverview> allResourceOverviews;
  const ResourcesSection({
    super.key,
    required this.activeChild,
    required this.allResourceOverviews,
  });

  @override
  State<ResourcesSection> createState() => ResourcesSectionState();
}

class ResourcesSectionState extends State<ResourcesSection> {
  List<DevelopmentalResourceOverview>? filteredResources;
  Key _activitiesKey = UniqueKey();
  final List<int> _filters = [
    DevelopmentalResourceOverview.activityCategory,
    DevelopmentalResourceOverview.tipsCategory
  ];

  void _updateActivitiesKey() {
    _activitiesKey = UniqueKey(); // generate a new key
    setState(() {}); // rebuild the widget
  }

  void filterResources() {
    filteredResources = widget.allResourceOverviews
        .where((element) => _filters.contains(element.resourceCategory))
        .toList();
    setState(() {});
  }

  void goToActivityContentPage(DevelopmentalResourceOverview activity) async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ActivityContentPage(
        activeChild: widget.activeChild,
        resourceOverview: activity,
      );
    })).then((value) => _updateActivitiesKey());
  }

  @override
  void initState() {
    super.initState();
    filterResources();
  }

  @override
  Widget build(BuildContext context) {
    List<DevelopmentalResourceOverview> pinnedList = widget.allResourceOverviews
        .where(
          (element) => DevelopmentalResourceOverview.isResourcePinned(
            child: widget.activeChild,
            resourceID: element.resourceID,
          ),
        )
        .toList();

    return Scaffold(
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            pinnedList != null
                ? Visibility(
                    visible: pinnedList.isNotEmpty,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 20),
                          child: Text(
                            'Pinned',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                        SizedBox(
                          height: 400,
                          child: ListView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            scrollDirection: Axis.horizontal,
                            itemCount: pinnedList.length,
                            itemBuilder: (context, index) {
                              return CustomRecommendationItem(
                                imageURL: pinnedList[index].imageURL,
                                title: pinnedList[index].title,
                                category: DevelopmentalResourceOverview
                                    .getResourceCategoryString(
                                        pinnedList[index].resourceCategory),
                                description: pinnedList[index].description,
                                onTap: () {
                                  goToActivityContentPage(pinnedList[index]);
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                : const SizedBox.shrink(),
            const SizedBox(height: 20),
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
                      selected: _filters.contains(
                          DevelopmentalResourceOverview.activityCategory),
                      onSelected: (selected) {
                        setState(() {
                          if (selected) {
                            _filters.add(
                                DevelopmentalResourceOverview.activityCategory);
                          } else if (_filters.length == 2) {
                            _filters.remove(
                                DevelopmentalResourceOverview.activityCategory);
                          }
                        });
                        filterResources();
                      },
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    FilterChip(
                      label: const Text('Tips'),
                      selected: _filters
                          .contains(DevelopmentalResourceOverview.tipsCategory),
                      onSelected: (selected) {
                        setState(() {
                          if (selected) {
                            _filters.add(
                                DevelopmentalResourceOverview.tipsCategory);
                          } else if (_filters.length == 2) {
                            _filters.remove(
                                DevelopmentalResourceOverview.tipsCategory);
                          }
                        });
                        filterResources();
                      },
                    )
                  ]),
                ],
              ),
            ),
            const SizedBox(height: 20),
            filteredResources != null
                ? ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: filteredResources!.length,
                    itemBuilder: (context, index) {
                      return CustomMaterialItem(
                        imageURL: filteredResources![index].imageURL,
                        title: filteredResources![index].title,
                        category: DevelopmentalResourceOverview
                            .getResourceCategoryString(
                                filteredResources![index].resourceCategory),
                        description: filteredResources![index].description,
                        onTap: () {
                          if (widget.activeChild != null &&
                              widget.allResourceOverviews != null) {
                            goToActivityContentPage(filteredResources![index]);
                          }
                        },
                      );
                    },
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
          ],
        ),
      ),
    );
  }
}
