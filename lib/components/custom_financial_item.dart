import 'package:flutter/material.dart';

class CustomFinancialItem extends StatelessWidget {
  const CustomFinancialItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        onTap: () {},
        leading: Image.network(
          'https://play-lh.googleusercontent.com/b60f8bzdLdXPgmJ7oAJyLTneTfDnRTimi4hXHWtLWYlJpyhLCibhKaBI5oMU6GQ1xg',
        ),
        title: Text(
          'Family and Community Welfare Program (FCWP)',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        subtitle: Text(
          'Thie program aims to help disadvantaged families improve their ability to identify needs',
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ),
    );
  }
}
