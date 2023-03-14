import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class AddChild extends StatelessWidget {
  const AddChild({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back',
          onPressed: () => {},
        ),
        title: Text(
          "Add Child",
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 150,
              width: 150,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: BoxDecoration(shape: BoxShape.circle),
              child: Image.network(
                "https://childmind.org/wp-content/uploads/2021/07/our-impact-header-half-r.jpg",
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Name",
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Date",
                    suffixIcon: IconButton(
                      icon: Icon(Icons.calendar_month_sharp),
                      tooltip: 'Date',
                      onPressed: () => {},
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            FilledButton(
              onPressed: () => {},
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text("Save"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
