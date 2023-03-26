import 'package:flutter/material.dart';

class CustomListItem extends StatelessWidget {
  final Widget leading;
  final String titleData;
  final String subtitleData;

  const CustomListItem({
    super.key,
    required this.leading,
    required this.titleData,
    required this.subtitleData,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 5),
        child: ListTile(
          leading: leading,
          title: Text(
            titleData,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          subtitle: Text(
            subtitleData,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          trailing: IconButton(
            icon: Icon(Icons.arrow_right),
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}
