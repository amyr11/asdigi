import 'package:flutter/material.dart';

import '../models/child.dart';

class ChildListItem extends StatelessWidget {
  final Child child;
  final void Function() onTap;

  const ChildListItem({
    super.key,
    required this.child,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: CircleAvatar(
        backgroundImage: child.imageURL == null
            ? const NetworkImage(
                'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png')
            : NetworkImage(child.imageURL!),
      ),
      title: Text(
        child.name,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}
