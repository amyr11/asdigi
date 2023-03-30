import 'package:flutter/material.dart';

class MilestoneCheclistItemCard extends StatefulWidget {
  final bool enabled;
  final String imageURL;
  final String title;
  final int intialSelected;
  final void Function(int choice) onChangeSelected;

  const MilestoneCheclistItemCard({
    super.key,
    this.enabled = true,
    required this.imageURL,
    required this.title,
    this.intialSelected = -1,
    required this.onChangeSelected,
  });

  @override
  State<MilestoneCheclistItemCard> createState() =>
      _MilestoneCheclistItemCardState();
}

class _MilestoneCheclistItemCardState extends State<MilestoneCheclistItemCard> {
  late int _milestoneStatus;

  void _handleChipSelected(int index) {
    setState(() {
      _milestoneStatus = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _milestoneStatus = widget.intialSelected;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.transparent,
      borderOnForeground: true,
      clipBehavior: Clip.hardEdge,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 200,
            child: Image.network(
              widget.imageURL,
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text(
                  widget.title,
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: widget.enabled
                      ? [
                          FilterChip(
                            avatar: const Icon(Icons.check),
                            showCheckmark: false,
                            selectedColor: Colors.green[100],
                            label: const Text('Yes'),
                            selected: _milestoneStatus == 0,
                            onSelected: (isSelected) {
                              _handleChipSelected(0);
                              widget.onChangeSelected(0);
                            },
                          ),
                          const SizedBox(width: 8),
                          FilterChip(
                            showCheckmark: false,
                            label: const Text('Not sure'),
                            selected: _milestoneStatus == 1,
                            onSelected: (isSelected) {
                              _handleChipSelected(1);
                              widget.onChangeSelected(1);
                            },
                          ),
                          const SizedBox(width: 8),
                          FilterChip(
                            avatar: const Icon(Icons.close),
                            selectedColor: Colors.red[100],
                            showCheckmark: false,
                            label: const Text('Not yet'),
                            selected: _milestoneStatus == 2,
                            onSelected: (isSelected) {
                              _handleChipSelected(2);
                              widget.onChangeSelected(2);
                            },
                          ),
                        ]
                      : [
                          Text(
                            'Status: ',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          Card(
                            shadowColor: Colors.transparent,
                            color: _milestoneStatus == 0
                                ? Colors.green[100]
                                : _milestoneStatus == 1
                                    ? Colors.purple[50]
                                    : _milestoneStatus == 2
                                        ? Colors.red[100]
                                        : Colors.grey[200],
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 12),
                              child: Text(
                                _milestoneStatus == 0
                                    ? 'Yes'
                                    : _milestoneStatus == 1
                                        ? 'Not sure'
                                        : _milestoneStatus == 1
                                            ? 'Not yet'
                                            : 'No Status',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ),
                          ),
                        ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
