import 'package:flutter/material.dart';

import '../components/custom_list_item.dart';
import '../temp/temp_data.dart';

class BehaviorDictionaryPage extends StatelessWidget {
  const BehaviorDictionaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                showSearch(context: context, delegate: CustomSearchDelegate());
              },
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Search Behavior',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color:
                              Theme.of(context).colorScheme.onSurfaceVariant),
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
              itemCount: BehaviorDictionaryPageData.listItems.length,
              shrinkWrap: true,
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
              itemBuilder: (BuildContext context, int index) =>
                  BehaviorDictionaryPageData.listItems[index],
            ),
          )
        ],
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
    for (CustomListItem item in BehaviorDictionaryPageData.listItems) {
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
    for (CustomListItem item in BehaviorDictionaryPageData.listItems) {
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
