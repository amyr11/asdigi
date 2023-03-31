import 'package:flutter/material.dart';

import '../models/behavior.dart';
import '../screens/behavior_content.dart';

class BehaviorListItem extends StatelessWidget {
  final Behavior behaviorObject;
  const BehaviorListItem(
    this.behaviorObject, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      visualDensity: VisualDensity.compact,
      leading: behaviorObject.image,
      title: Text(
        behaviorObject.title,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      subtitle: Text(
        behaviorObject.description,
        style: Theme.of(context).textTheme.bodyMedium,
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
      ),
      trailing: const Icon(Icons.arrow_right),
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation) {
              return BehaviorContentPage(behaviorObject: behaviorObject);
            },
            transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
                Widget child) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(1.0, 0.0),
                  end: Offset.zero,
                ).animate(CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeInOut,
                )),
                child: child,
              );
            },
          ),
        );
      },
    );
  }
}
