import 'package:flutter/material.dart';
import 'package:markdown_viewer/markdown_viewer.dart';

import '../models/child.dart';
import '../models/developmental_resource.dart';

class ActivityContentPage extends StatefulWidget {
  final Child activeChild;
  final DevelopmentalResourceOverview resourceOverview;

  const ActivityContentPage({
    super.key,
    required this.activeChild,
    required this.resourceOverview,
  });

  @override
  State<ActivityContentPage> createState() => _ActivityContentPageState();
}

class _ActivityContentPageState extends State<ActivityContentPage> {
  DevelopmentalResourceContent? resourceContent;

  void fetchResourceContent() async {
    resourceContent = await DevelopmentalResourceContent.getDataFromFirestore(
        widget.resourceOverview.resourceID!);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchResourceContent();
  }

  @override
  Widget build(BuildContext context) {
    bool isPinned = (widget.activeChild.pinnedResourcesID == null)
        ? false
        : DevelopmentalResourceOverview.isResourcePinned(
            child: widget.activeChild,
            resourceID: widget.resourceOverview.resourceID,
          );

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.resourceOverview.title),
        actions: [
          IconButton(
            icon: Icon(
              isPinned ? Icons.star : Icons.star_border_outlined,
            ),
            color: isPinned ? const Color.fromARGB(255, 242, 199, 9) : null,
            onPressed: () {
              setState(() {
                if (isPinned) {
                  widget.activeChild.pinnedResourcesID!
                      .remove(widget.resourceOverview.resourceID);
                } else {
                  widget.activeChild.pinnedResourcesID ??= [];
                  widget.activeChild.pinnedResourcesID!
                      .add(widget.resourceOverview.resourceID!);
                }
                Child.updatePinnedResourceID(widget.activeChild);
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: resourceContent != null
                ? MarkdownViewer(resourceContent!.content)
                : const Center(
                    child: CircularProgressIndicator(),
                  )),
      ),
    );
  }
}
