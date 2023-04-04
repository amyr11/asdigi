import 'package:flutter/material.dart';

class ChildListItem extends StatelessWidget {
  String? imageURL;
  final String name;

  ChildListItem({
    super.key,
    this.imageURL,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      leading: CircleAvatar(
        backgroundImage: imageURL == null
            ? const NetworkImage(
                'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png')
            : NetworkImage(imageURL!),
      ),
      title: Text(
        name,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}
