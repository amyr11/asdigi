import 'package:flutter/material.dart';
import 'dart:ui';

class CustomDoctorItem extends StatelessWidget {
  final Image pfp;
  final String docName;
  final String docOccupation;
  final String description;
  final String hospitalName;
  final String address;
  final String trunkLine;

  const CustomDoctorItem({
    super.key,
    required this.pfp,
    required this.docName,
    required this.docOccupation,
    required this.description,
    required this.address,
    required this.trunkLine,
    required this.hospitalName,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundImage: pfp.image,
              ),
              title: Text(
                docName,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              subtitle: Text(
                docOccupation,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              trailing: IconButton(
                icon: Icon(Icons.more_vert),
                onPressed: () {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    description,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    hospitalName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  Text(
                    address,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                    trunkLine,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      OutlinedButton(
                        onPressed: () {},
                        child: const Text('Email'),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      FilledButton(
                        onPressed: () {},
                        child: const Text('Add to Contacts'),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
