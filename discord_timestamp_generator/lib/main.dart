import 'package:discord_timestamp_generator/utility/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import "./home_page.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeNotifier themeNotifier = ThemeNotifier();

  @override
  void initState() {
    super.initState();
    themeNotifier.addListener(() {
      setState(() {});
    });
  }

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
      themeMode: themeNotifier.currentTheme(),
      home: ChangeNotifierProvider.value(
          value: themeNotifier, child: const HomePage()),
    );
  }
}
