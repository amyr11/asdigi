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
            Stack(children: [
              Container(
                height: 150,
                width: 150,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: const BoxDecoration(shape: BoxShape.circle),
                child: Image.network(
                  "https://childmind.org/wp-content/uploads/2021/07/our-impact-header-half-r.jpg",
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 100, left: 100),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                      )
                    ],
                    shape: BoxShape.circle,
                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: IconButton(
                    onPressed: () => {},
                    icon: Icon(Icons.edit),
                  ),
                ),
              ),
            ]),
            const SizedBox(
              height: 40,
            ),
            Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    isDense: true,
                    border: OutlineInputBorder(),
                    labelText: "Name",
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    isDense: true,
                    border: const OutlineInputBorder(),
                    labelText: "Date",
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.calendar_month_sharp),
                      tooltip: 'Date',
                      onPressed: () => {},
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            FilledButton(
              onPressed: () => {},
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  "Save",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
