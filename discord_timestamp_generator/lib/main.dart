import 'package:flutter/material.dart';
import "./home_page.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Discord Timestamp Generator',
      theme: ThemeData(
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.grey),
        useMaterial3: true,
        /* light theme settings */
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.grey, brightness: Brightness.dark),
        useMaterial3: true,
        /* dark theme settings */
      ),
      themeMode: ThemeMode.dark,
      home: const HomePage(),
    );
  }
}
