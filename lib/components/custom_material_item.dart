import 'package:flutter/material.dart';

class CustomMaterialItem extends StatelessWidget {
  const CustomMaterialItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(
          'https://content.presentermedia.com/files/clipart/00014000/14170/light_bulb_sketch_800_wht.jpg'),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Category',
            style: Theme.of(context).textTheme.labelMedium,
          ),
          Text(
            'Title',
            style: Theme.of(context).textTheme.bodyLarge,
          )
        ],
      ),
      subtitle: Text(
        'Supporting line text lorem ipsum dolor sit amet, consectetur',
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      trailing: IconButton(
        icon: Icon(Icons.arrow_right),
        onPressed: () {},
      ),
    );
  }
}
