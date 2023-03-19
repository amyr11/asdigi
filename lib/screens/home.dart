import 'package:flutter/material.dart';

import '../components/app_bar_profile.dart';
import '../components/custom_nav_bar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _Home();
}

List<Widget> listItems = [
  CustomListItem(
    leading: Image.network(
      'https://thumbs.dreamstime.com/b/wood-texture-3753136.jpg',
      width: 56,
      height: 56,
    ),
    titleData: 'Title 1',
    subtitleData: 'Subtitle',
  ),
  CustomListItem(
    leading: Image.network(
      'https://thumbs.dreamstime.com/b/wood-texture-3753136.jpg',
      width: 56,
      height: 56,
    ),
    titleData: 'Title 2',
    subtitleData: 'Subtitle',
  ),
  CustomListItem(
    leading: Image.network(
      'https://thumbs.dreamstime.com/b/wood-texture-3753136.jpg',
      width: 56,
      height: 56,
    ),
    titleData: 'Title 3',
    subtitleData: 'Subtitle',
  ),
];

class _Home extends State<Home> {
  int currentPageIndex = 0;
  String searchText = '';

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
          child: Text(
            'Page 3',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        Container(
          alignment: Alignment.center,
          child: Text(
            'Page 4',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        Container(
          alignment: Alignment.center,
          child: Text(
            'Page 5',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
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
          trailing: Icon(Icons.arrow_right),
        ),
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  List<String> searchTerms = [
    'item #1',
    'item #2',
    'item #3',
    'item #4',
    'item #5',
    'item #6',
    'item #7',
  ];

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
    List<String> matchQuery = [];
    for (var item in searchTerms) {
      if (item.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(item);
      }
    }

    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var item in searchTerms) {
      if (item.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(item);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }
}



// Container(
//       child: Padding(
//         padding: EdgeInsets.symmetric(vertical: 5),
//         child: ListTile(
//           leading: Image.network(
//             'https://thumbs.dreamstime.com/b/wood-texture-3753136.jpg',
//             width: 56,
//             height: 56,
//           ),
//           title: Text(
//             'Title 1',
//             style: Theme.of(context).textTheme.bodyLarge,
//           ),
//           subtitle: Text(
//             'Supporting line text lorem ipsum dolor sit amet, consectetur',
//             style: Theme.of(context).textTheme.bodyMedium,
//           ),
//           trailing: Icon(Icons.arrow_right),
//         ),
//       ),
//     );