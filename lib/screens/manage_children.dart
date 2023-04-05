import 'package:flutter/material.dart';

import '../components/custom_child_item.dart';
import '../models/child.dart';

class ManageChildrenPage extends StatefulWidget {
  final void Function() onRefresh;

  const ManageChildrenPage({
    super.key,
    required this.onRefresh,
  });

  @override
  State<ManageChildrenPage> createState() => _ManageChildrenPageState();
}

class _ManageChildrenPageState extends State<ManageChildrenPage> {
  List<Child>? children;

  void fetchChildren() async {
    children = await Child.getAllFromFirestore();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchChildren();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Children'),
      ),
      body: children != null
          ? SingleChildScrollView(
              child: ListView.separated(
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) => ChildListItem(
                  child: children![index],
                  updateScreen: () {
                    fetchChildren();
                    widget.onRefresh();
                  },
                  showDelete: true,
                ),
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
                itemCount: children!.length,
              ),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
