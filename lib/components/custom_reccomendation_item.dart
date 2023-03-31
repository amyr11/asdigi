import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomRecommendationItem extends StatelessWidget {
  final Image backgroundImage;
  final String title;
  final String category;
  final String description;
  final void Function()? onTap;

  const CustomRecommendationItem({
    super.key,
    required this.backgroundImage,
    required this.title,
    required this.category,
    required this.description,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
      width: 260,
      child: Card(
        shadowColor: Colors.transparent,
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          onTap: onTap,
          child: Column(
            children: [
              backgroundImage,
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Text(
                      category,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      description,
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
