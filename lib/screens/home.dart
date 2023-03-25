import 'package:flutter/material.dart';
import '../components/app_bar_profile.dart';
import '../components/custom_material_item.dart';
import '../components/custom_nav_bar.dart';
import '../components/custom_reccomendation_item.dart';
import 'doctors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

enum materialFilter { Activities, Tips }

List<CustomListItem> listItems = [
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

class _HomePage extends State<HomePage> {
  int currentPageIndex = 0;
  String searchText = '';

  bool favorite = true;
  final List<String> _filters = <String>[];

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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                'Behavior Dictionary',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                'Understand your child more',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(
                height: 20,
              ),
              Material(
                borderRadius: BorderRadius.circular(50),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                color: Theme.of(context).colorScheme.surfaceVariant,
                child: InkWell(
                  onTap: () {
                    showSearch(
                        context: context, delegate: CustomSearchDelegate());
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Search Behavior',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurfaceVariant),
                        ),
                        const Icon(Icons.search),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: ListView.separated(
                  itemCount: listItems.length,
                  shrinkWrap: true,
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(),
                  itemBuilder: (BuildContext context, int index) =>
                      listItems[index],
                ),
              )
            ],
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
            child: DefaultTabController(
              length: 4,
              child: Scaffold(
                appBar: AppBar(
                  toolbarHeight: 0,
                  bottom: TabBar(
                    tabs: [
                      Tab(
                        child: Text(
                          'Social',
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ),
                      Tab(
                        child: Text(
                          'Language',
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ),
                      Tab(
                        child: Text(
                          'Cognitive',
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ),
                      Tab(
                        child: Text(
                          'Movement',
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ),
                    ],
                  ),
                ),
                body: Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: TabBarView(
                    children: [
                      SingleChildScrollView(
                        physics: AlwaysScrollableScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Text(
                                'Recommended',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ),
                            Container(
                              height: 350,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: 5,
                                itemBuilder: (context, index) {
                                  return CustomRecommendationItem();
                                },
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'All Materials',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              child: Row(
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
                                            if (!_filters
                                                .contains(filter.name)) {
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
                            ),
                            ListView.separated(
                              physics: BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: 5,
                              separatorBuilder: (context, index) {
                                return const Divider();
                              },
                              itemBuilder: (context, index) {
                                return CustomMaterialItem();
                              },
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )),
        Container(
          child: Text(
            'Page 4',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        DoctorsPage(),
      ][currentPageIndex],
    );
  }
}

class CustomListItem extends StatelessWidget {
  final Widget leading;
  final String titleData;
  final String subtitleData;

  const CustomListItem({
    super.key,
    required this.leading,
    required this.titleData,
    required this.subtitleData,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 5),
        child: ListTile(
          leading: leading,
          title: Text(
            titleData,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          subtitle: Text(
            subtitleData,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          trailing: IconButton(
            icon: Icon(Icons.arrow_right),
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<CustomListItem> matchQuery = [];
    for (CustomListItem item in listItems) {
      if (item.titleData.toLowerCase().contains(query.toLowerCase()) ||
          item.subtitleData.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(item);
      }
    }

    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return result;
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<CustomListItem> matchQuery = [];
    for (CustomListItem item in listItems) {
      if (item.titleData.toLowerCase().contains(query.toLowerCase()) ||
          item.subtitleData.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(item);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return result;
      },
    );
  }
}
