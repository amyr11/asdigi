import 'package:flutter/material.dart';
import '../components/app_bar_profile.dart';
import '../components/custom_nav_bar.dart';
import 'doctors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

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
  int currentPageIndex = 2;
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