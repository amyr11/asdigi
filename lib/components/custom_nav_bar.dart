import 'package:flutter/material.dart';

class CustomNavBar extends StatelessWidget {
  const CustomNavBar({
    super.key,
    required this.currentPageIndex,
    required this.onDestinationSelected,
  });

  final int currentPageIndex;
  final void Function(int) onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      onDestinationSelected: onDestinationSelected,
      selectedIndex: currentPageIndex,
      destinations: const <Widget>[
        NavigationDestination(
          selectedIcon: Icon(Icons.library_books),
          icon: Icon(Icons.library_books_outlined),
          label: 'Dictionary',
        ),
        NavigationDestination(
          selectedIcon: Icon(Icons.location_on),
          icon: Icon(Icons.location_on_outlined),
          label: 'Milestones',
        ),
        NavigationDestination(
          selectedIcon: Icon(Icons.star),
          icon: Icon(Icons.star_border),
          label: 'Activities',
        ),
        NavigationDestination(
          selectedIcon: Icon(Icons.language),
          icon: Icon(Icons.language_outlined),
          label: 'Community',
        ),
        NavigationDestination(
          selectedIcon: Icon(Icons.medical_information),
          icon: Icon(Icons.medical_information_outlined),
          label: 'Doctors',
        ),
      ],
    );
  }
}
