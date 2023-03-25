import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomRecommendationItem extends StatelessWidget {
  // final Image backgroundImage;
  // final String title;
  // final String category;
  // final String description;
  // final bool isPinned;

  const CustomRecommendationItem({
    super.key,
    // required this.backgroundImage,
    // required this.title,
    // required this.category,
    // required this.description,
    // required this.isPinned,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
        width: 260,
        child: Card(
          clipBehavior: Clip.hardEdge,
          child: Column(
            children: [
              Image.network(
                  'https://cdn.pixabay.com/photo/2012/08/27/14/19/mountains-55067__340.png'),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Title',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Text(
                      'Category',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor',
                      style: Theme.of(context).textTheme.bodyMedium,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
