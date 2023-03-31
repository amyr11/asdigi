import 'package:flutter/material.dart';
import '../helpers/auth_services.dart';
import 'circle_image_button.dart';
import 'package:side_sheet/side_sheet.dart';

// TODO: Change image path to children's image
const String imagePath = 'assets/images/boy.jpg';

class AppBarWithProfile extends AppBar {
  final BuildContext context;

  AppBarWithProfile(
    this.context, {
    super.key,
  }) : super(
          leading: const CircleImageButton(
            image: AssetImage(imagePath),
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
