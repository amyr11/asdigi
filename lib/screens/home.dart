import 'package:flutter/material.dart';

import '../components/app_bar_profile.dart';
import '../components/custom_nav_bar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _Home();
}

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
                  onTap: () {},
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
                  itemCount: 15,
                  shrinkWrap: true,
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(),
                  itemBuilder: (BuildContext context, int index) => Container(
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: ListTile(
                        leading: Icon(Icons.icecream),
                        title: Text('I like icecream'),
                        subtitle: Text('Icream is good for health'),
                        trailing: Icon(Icons.food_bank),
                      ),
                    ),
                  ),
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

// TextField(
//                 decoration: InputDecoration(
//                   fillColor: Theme.of(context).colorScheme.surfaceVariant,
//                   filled: true,
//                   border: InputBorder.none,
//                   hintText: 'Search',
//                   suffixIcon: IconButton(
//                     icon: const Icon(Icons.search),
//                     onPressed: () {},
//                   ),
//                 ),
//               ),
