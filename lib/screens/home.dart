import 'dart:html';
import 'dart:math';

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
        Container(
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16, top: 20),
                child: Text(
                  'Behavior Dictionary',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Text(
                  'Understand your child more',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(28)),
                      hintText: 'Search',
                      suffixIcon: IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () {},
                      )),
                ),
              ),
              Expanded(
                child: ListView.separated(
                  itemCount: 15,
                  shrinkWrap: true,
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(),
                  itemBuilder: (BuildContext context, int index) => Container(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 4, 16, 5),
                      child: Row(
                        children: [
                          Image.network(
                            'https://thumbs.dreamstime.com/b/wood-texture-3753136.jpg',
                            width: 56,
                            height: 56,
                          ),
                          Container(
                            constraints: const BoxConstraints(minWidth: 228),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text('Title',
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
                                      softWrap: true),
                                  Text(
                                      'Supporting line text lorem ipsum dolor sit amet, consectetur',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                      softWrap: true)
                                ],
                              ),
                            ),
                          ),
                          IconButton(
                              onPressed: () {}, icon: Icon(Icons.arrow_right))
                        ],
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
