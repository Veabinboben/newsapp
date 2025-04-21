import 'package:flutter/material.dart';
import 'package:newsapp/data/repository/concrete_repository.dart';

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const NavScaffold(),
    );
  }
}

class NavScaffold extends StatelessWidget {
  const NavScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("1"),
      ),
    );
  }
}


