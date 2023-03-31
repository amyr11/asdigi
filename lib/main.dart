import 'package:asdigi/screens/behavior_content.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:asdigi/helpers/auth_services.dart';
import 'package:flutter/material.dart';

import 'screens/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _myAppState();
}

class _myAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ASDigi',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: AuthServices().handleAuthState(),
      debugShowCheckedModeBanner: false,
    );
  }
}
