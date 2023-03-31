import 'dart:ui';

import 'package:asdigi/screens/add_child.dart';
import 'package:flutter/material.dart';
import '../helpers/auth_services.dart';
import '../models/child.dart';
import 'circle_image_button.dart';
import 'custom_child_item.dart';

// TODO: Change image path to children's image
const String imagePath = 'assets/images/boy.jpg';

List<Child> children = [
  Child(Image.asset('assets/images/boy.jpg'), 'Juan Cruz', '12/12/2003'),
  Child(Image.asset('assets/images/boy.jpg'), 'Karl', '11/06/2003'),
];

class AppBarWithProfile extends AppBar {
  final BuildContext context;
  AppBarWithProfile(
    this.context, {
    super.key,
  }) : super(
          leading: CircleImageButton(
            image: AssetImage(imagePath),
            onTap: () => showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                icon: Icon(Icons.person_2_outlined),
                title: const Text('Switch Child'),
                content: ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) =>
                        custom_child_item(
                            pfp: children[index].image,
                            name: children[index].name),
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(),
                    itemCount: children.length),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AddChild()));
                    },
                    child: Text('+ Add Child'),
                  )
                ],
              ),
            ),
          ),
          centerTitle: true,
          title: Column(
            children: [
              Text(
                "Juan",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                "5 years old",
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {
                // TODO: Change by adding setting screen
                // AuthServices().signOut();
              },
              icon: const Icon(Icons.settings),
              tooltip: 'Settings',
            ),
          ],
        );
}
