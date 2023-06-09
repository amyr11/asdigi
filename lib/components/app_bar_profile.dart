import 'package:asdigi/screens/add_child.dart';
import 'package:flutter/material.dart';
import '../helpers/auth_services.dart';
import '../models/child.dart';
import '../screens/manage_children.dart';
import 'circle_image_button.dart';
import 'package:side_sheet/side_sheet.dart';
import 'custom_child_item.dart';

class AppBarWithProfile extends AppBar {
  final BuildContext context;
  final Child? activeChild;
  final Function(Child selectedChild) onChildTap;
  final Function() onRefresh;

  AppBarWithProfile(
    this.context, {
    super.key,
    required this.onRefresh,
    required this.activeChild,
    required this.onChildTap,
  }) : super(
          leading: CircleImageButton(
            image: (activeChild == null || activeChild.imageURL == null)
                ? const NetworkImage(
                    "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png")
                : NetworkImage(activeChild.imageURL!),
            onTap: () {
              Child.getAllFromFirestore().then((children) {
                showDialog<String>(
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
                              child: children[index],
                              onTap: () {
                                Navigator.of(context).pop();
                                onChildTap(children[index]);
                              },
                            ),
                            separatorBuilder:
                                (BuildContext context, int index) =>
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
                );
              });
            },
          ),
          centerTitle: true,
          title: Column(
            children: [
              Text(
                (activeChild == null) ? '' : activeChild.name,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                (activeChild == null)
                    ? ''
                    : Child.getAgeStringInYears(activeChild.ageInMonths),
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
                    child: Column(
                      children: [
                        ListTile(
                          leading: Icon(Icons.person),
                          title: Text('Manage Children'),
                          trailing: Icon(Icons.arrow_right),
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ManageChildrenPage(
                                  onRefresh: onRefresh,
                                ),
                              ),
                            );
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.logout),
                          title: Text('Sign Out'),
                          trailing: Icon(Icons.arrow_right),
                          onTap: () {
                            Navigator.pop(context);
                            AuthServices().signOut();
                          },
                        ),
                      ],
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
