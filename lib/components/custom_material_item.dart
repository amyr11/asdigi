import 'package:flutter/material.dart';

class CustomMaterialItem extends StatelessWidget {
  final Image backgroundImage;
  final String title;
  final String category;
  final String description;

  const CustomMaterialItem({
    super.key,
    required this.backgroundImage,
    required this.title,
    required this.category,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      visualDensity: VisualDensity.compact,
      onTap: () {},
      leading: backgroundImage,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            category,
            style: Theme.of(context).textTheme.labelMedium,
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.bodyLarge,
          )
        ],
      ),
      subtitle: Text(
        description,
        style: Theme.of(context).textTheme.bodyMedium,
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
      ),
      trailing: const Icon(Icons.arrow_right),
    );
  }
}
