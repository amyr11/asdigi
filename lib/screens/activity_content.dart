import 'package:flutter/material.dart';
import 'package:markdown_viewer/markdown_viewer.dart';

import '../models/developmentalActivity.dart';

class ActivityContentPage extends StatefulWidget {
  final DevelopmentalActivity activity;

  const ActivityContentPage(this.activity, {super.key});

  @override
  State<ActivityContentPage> createState() => _ActivityContentPageState();
}

class _ActivityContentPageState extends State<ActivityContentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.activity.title),
        actions: [
          IconButton(
            icon: Icon(
              widget.activity.isPinned
                  ? Icons.star
                  : Icons.star_border_outlined,
            ),
            color: widget.activity.isPinned
                ? Color.fromARGB(255, 242, 199, 9)
                : null,
            onPressed: () {
              setState(() {
                widget.activity.isPinned = !widget.activity.isPinned;
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: MarkdownViewer(widget.activity.content),
        ),
      ),
    );
  }
}
