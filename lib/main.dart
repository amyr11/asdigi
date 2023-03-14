import 'package:asdigi/screens/activities.dart';
import 'package:flutter/material.dart';

import 'screens/add_child.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const AddChild(),
      debugShowCheckedModeBanner: false,
    );
  }
}
