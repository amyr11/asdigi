import 'package:flutter/material.dart';
import '../helpers/auth_services.dart';
import 'circle_image_button.dart';

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
                // TODO: Change by adding setting screen
                AuthServices().signOut();
              },
              icon: const Icon(Icons.settings),
              tooltip: 'Settings',
            ),
          ],
        );
}
