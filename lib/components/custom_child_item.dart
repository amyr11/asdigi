import 'package:flutter/material.dart';

import '../models/child.dart';
import '../models/user.dart';

class ChildListItem extends StatelessWidget {
  final Child child;
  final void Function()? onTap;
  final void Function()? updateScreen;
  final bool showDelete;

  const ChildListItem({
    super.key,
    required this.child,
    this.onTap,
    this.updateScreen,
    this.showDelete = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: CircleAvatar(
        backgroundImage: child.imageURL == null
            ? const NetworkImage(
                'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png')
            : NetworkImage(child.imageURL!),
      ),
      title: Text(
        child.name,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      trailing: showDelete
          ? IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text('Delete Child'),
                    content: const Text(
                        'Are you sure you want to delete this child?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () async {
                          String? activeChildID =
                              await CustomUser.getActiveChildID();
                          if (activeChildID != null) {
                            List<Child> children =
                                await Child.getAllFromFirestore();

                            int index = children.indexWhere(
                                (element) => element.childID == activeChildID);
                            children.removeAt(index);

                            if (activeChildID == child.childID &&
                                children.isNotEmpty) {
                              await CustomUser.updateActiveChildID(
                                  children.first.childID!);
                            } else if (activeChildID == child.childID &&
                                children.isEmpty) {
                              await CustomUser.updateActiveChildID(null);
                            }
                            await Child.deleteFromFirestore(child);
                            if (updateScreen != null) {
                              updateScreen!();
                            }
                          }
                          Navigator.pop(context);
                        },
                        child: const Text('Delete'),
                      ),
                    ],
                  ),
                );
              },
            )
          : const SizedBox.shrink(),
    );
  }
}
