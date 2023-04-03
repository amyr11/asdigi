import 'dart:ui';

import 'package:asdigi/screens/add_child.dart';
import 'package:flutter/material.dart';
import '../helpers/auth_services.dart';
import '../models/child.dart';
import 'circle_image_button.dart';
import 'package:side_sheet/side_sheet.dart';
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
              builder: (BuildContext context) => Dialog(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 20),
                    const Icon(Icons.person_2_outlined, size: 30),
                    const SizedBox(height: 10),
                    Text('Switch Child',
                        style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 20),
                    SingleChildScrollView(
                      child: ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) =>
                            ChildListItem(
                                pfp: children[index].image,
                                name: children[index].name),
                        separatorBuilder: (BuildContext context, int index) =>
                            const Divider(),
                        itemCount: children.length,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AddChild()),
                        );
                      },
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 20,
                        ),
                      ),
                      child: const Text('+ Add Child'),
                    ),
                  ],
                ),
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
                SideSheet.right(
                  body: Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: ListTile(
                      leading: Icon(Icons.logout),
                      title: Text('Sign Out'),
                      trailing: Icon(Icons.arrow_right),
                      onTap: () {
                        Navigator.pop(context);
                        AuthServices().signOut();
                      },
                    ),
                  ),
                  context: context,
                );
                // // TODO: Change by adding setting screen
              },
              icon: const Icon(Icons.settings),
              tooltip: 'Settings',
            ),
          ],
        );
}
