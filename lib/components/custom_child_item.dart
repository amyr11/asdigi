import 'package:flutter/material.dart';

class ChildListItem extends StatelessWidget {
  final Image pfp;
  final String name;

  const ChildListItem({
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
    );
  }
}
