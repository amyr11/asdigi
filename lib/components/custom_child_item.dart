import 'package:flutter/material.dart';

class custom_child_item extends StatelessWidget {
  Image pfp;
  String name;

  custom_child_item({
    super.key,
    required this.pfp,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      leading: CircleAvatar(backgroundImage: pfp.image),
      title: Text(
        name,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      trailing: IconButton(
        icon: Icon(Icons.more_vert),
        onPressed: () {},
      ),
    );
  }
}
