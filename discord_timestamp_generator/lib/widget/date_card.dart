import 'package:flutter/material.dart';

class DateCard extends StatelessWidget {
  final DateTime dateTime;
  final VoidCallback onPressed;
  const DateCard({super.key, required this.dateTime, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
          elevation: 0,
          color: Theme.of(context).colorScheme.surfaceVariant,
          child: const Text("Test")),
    );
  }
}
