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
            crossAxisAlignment: CrossAxisAlignment.start,
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
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                  hintText: 'Search',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {},
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



// Row(
//                     mainAxisSize: MainAxisSize.max,
//                     children: [
//                       Image.network(
//                         'https://thumbs.dreamstime.com/b/wood-texture-3753136.jpg',
//                         width: 56,
//                         height: 56,
//                       ),
//                       Column(
//                         mainAxisSize: MainAxisSize.max,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Title',
//                             style: Theme.of(context).textTheme.bodyLarge,
//                           ),
//                           Text(
//                             'Supporting line text lorem ipsum dolor sit amet, consectetur',
//                             style: Theme.of(context).textTheme.bodyMedium,
//                           )
//                         ],
//                       ),
//                       IconButton(
//                         onPressed: () {},
//                         icon: Icon(Icons.arrow_right),
//                       )
//                     ],
//                   ),