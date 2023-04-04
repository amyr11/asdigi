import 'package:flutter/material.dart';

class CustomMaterialItem extends StatelessWidget {
  final String imageURL;
  final String title;
  final String category;
  final String description;
  final void Function()? onTap;

  const CustomMaterialItem({
    super.key,
    required this.imageURL,
    required this.title,
    required this.category,
    required this.description,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      visualDensity: VisualDensity.compact,
      onTap: onTap,
      leading: Image.network(
        imageURL,
        fit: BoxFit.cover,
        height: 50,
        width: 80,
        alignment: Alignment.topCenter,
      ),
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
