import 'package:flutter/material.dart';

import '../components/behavior_list_item.dart';
import '../models/behavior.dart';
import '../temp/temp_data.dart';

class BehaviorDictionaryPage extends StatelessWidget {
  const BehaviorDictionaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        SliverAppBar(
          floating: true,
          snap: true,
          toolbarHeight: 100,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Behavior Dictionary',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                'Understand your child more',
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ],
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
              child: Material(
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
            ),
          ),
        ),
      ],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView.separated(
              itemCount: BehaviorDictionaryPageData.listItems.length,
              shrinkWrap: true,
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
              itemBuilder: (BuildContext context, int index) =>
                  BehaviorListItem(BehaviorDictionaryPageData.listItems[index]),
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
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<Behavior> matchQuery = [];
    for (Behavior behavior in BehaviorDictionaryPageData.listItems) {
      if (behavior.title.toLowerCase().contains(query.toLowerCase()) ||
          behavior.description.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(behavior);
      }
    }

    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return BehaviorListItem(result);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return buildResults(context);
  }
}



// Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               const SizedBox(
//                 height: 20,
//               ),
//               Text(
//                 'Behavior Dictionary',
//                 style: Theme.of(context).textTheme.titleLarge,
//               ),
//               Text(
//                 'Understand your child more',
//                 style: Theme.of(context).textTheme.titleSmall,
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
        //       Material(
        //         borderRadius: BorderRadius.circular(50),
        //         clipBehavior: Clip.antiAliasWithSaveLayer,
        //         color: Theme.of(context).colorScheme.surfaceVariant,
        //         child: InkWell(
        //           onTap: () {
        //             showSearch(
        //                 context: context, delegate: CustomSearchDelegate());
        //           },
        //           child: Padding(
        //             padding: const EdgeInsets.all(15),
        //             child: Row(
        //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //               children: [
        //                 Text(
        //                   'Search Behavior',
        //                   style: Theme.of(context)
        //                       .textTheme
        //                       .titleMedium!
        //                       .copyWith(
        //                           color: Theme.of(context)
        //                               .colorScheme
        //                               .onSurfaceVariant),
        //                 ),
        //                 const Icon(Icons.search),
        //               ],
        //             ),
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),