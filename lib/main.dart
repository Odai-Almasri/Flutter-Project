import 'package:flutter/material.dart';
import 'package:project/screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        // useMaterial3: true,

        primarySwatch: Colors.teal,
      ),
      home: const Home(),
    );
  }
}
