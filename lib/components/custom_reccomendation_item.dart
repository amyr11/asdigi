import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomRecommendationItem extends StatelessWidget {
  final String imageURL;
  final String title;
  final String category;
  final String description;
  final void Function()? onTap;

  const CustomRecommendationItem({
    super.key,
    required this.imageURL,
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
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 160,
                child: Image.network(
                  imageURL,
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.bodyLarge,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      category,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      description,
                      style: Theme.of(context).textTheme.bodyMedium,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
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
